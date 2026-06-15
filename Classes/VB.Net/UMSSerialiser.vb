Imports System.IO
Imports System.Reflection
Imports Boston.RDS
Imports de.jollyday.config
Imports YamlDotNet.Serialization
Imports YamlDotNet.Serialization.NamingConventions

Namespace UMS
    ' ─── Serialiser Factory ───────────────────────────────────────────────────────

    Public Class UmsSchemaSerializer

        Dim Model As FBM.Model


        ''' <summary>
        ''' Parameterless Constructor
        ''' </summary>
        Public Sub New()
        End Sub

        Public Sub New(ByRef arModel As FBM.Model)
            Me.Model = arModel
        End Sub

        Public Function GenerateUMS(Optional ByRef arModelElement As FBM.ModelObject = Nothing) As String


            Try

                Dim lrTypeDefinition As UMS.TypeDefinition 'EntityTypes, UnifiedFactTypes. I.e. E.g. Node Types (graph), Entities (relational).

                'Set up the Schema Object/List of UMS.TypeDefinition
                Dim larUnifiedModellingSchema As New List(Of UMS.TypeDefinition)

                If arModelElement Is Nothing Then

                    For Each lrTable In Me.Model.RDS.Table

                        lrTypeDefinition = New UMS.TypeDefinition
                        lrTypeDefinition.Name = lrTable.Name

                        Dim lrModelElement As FBM.ModelObject = lrTable.FBMModelElement

#Region "PrimaryKey"
                        Dim lrPrimaryKey = lrTable.Index.Find(Function(x) x.IsPrimaryKey)

                        If lrPrimaryKey IsNot Nothing Then

                            If lrTypeDefinition.PrimaryKey Is Nothing Then lrTypeDefinition.PrimaryKey = New List(Of String)

                            For Each lrColumn In lrPrimaryKey.Column
                                lrTypeDefinition.PrimaryKey.Add(lrColumn.Name)
                            Next
                        End If
#End Region

                        'Graph Label/s
#Region "Label/s"
                        For Each lrGraphLabel In lrModelElement.GraphLabel

                            If lrTable.isPGSRelation Then
                                lrTypeDefinition.Label = lrGraphLabel.Label

                                Dim lrFactType As FBM.FactType = lrModelElement
                                lrTypeDefinition.Source = lrFactType.Source
                                lrTypeDefinition.Target = lrFactType.Target

                                Exit For
                            End If

                            If lrTypeDefinition.Labels Is Nothing Then lrTypeDefinition.Labels = New List(Of String)

                            lrTypeDefinition.Labels.Add(lrGraphLabel.Label)

                        Next

                        If lrTypeDefinition.Labels Is Nothing And lrTypeDefinition.Label Is Nothing Then
                            'No GraphLabels, and not a PGS Relation, but still requires a Label
                            lrTypeDefinition.Labels = New List(Of String)
                            lrTypeDefinition.Labels.AddUnique(lrTable.Name)
                        End If
#End Region

#Region "RelationshipAnnotation"
                        If lrModelElement.GetType = GetType(FBM.FactType) Then

                            If Not lrTable.isPGSRelation Then
                                lrTypeDefinition.RelationshipAnnotation = Nothing
                            End If

                            Dim lrFactType As FBM.FactType = lrModelElement
                            Dim liInd = 0
                            For Each lrFactTypeReading In lrFactType.FactTypeReading

                                If lrTypeDefinition.TypeReadings Is Nothing Then lrTypeDefinition.TypeReadings = New List(Of String)

                                lrTypeDefinition.TypeReadings.Add(lrFactTypeReading.GetReadingText)

                                If liInd = 0 And lrTable.isPGSRelation Then
                                    lrTypeDefinition.RelationshipAnnotation = lrFactTypeReading.GetReadingText
                                End If

                                liInd += 1
                            Next

                        End If
#End Region

                        '==========================================================================================================================
                        'Properties
                        '------------
#Region "Properties"
                        For Each lrColumn In lrTable.Column

                            If lrTypeDefinition.Properties Is Nothing Then lrTypeDefinition.Properties = New List(Of UMS.PropertyDefinition)

                            Dim lrProperty = New UMS.PropertyDefinition

                            lrProperty.Name = lrColumn.Name

                            If lrColumn.IsMandatory Then
                                If lrProperty.Constraints Is Nothing Then lrProperty.Constraints = New List(Of UMS.Constraint)
                                lrProperty.Constraints.Add(UMS.Constraint.NotNull)
                            End If

                            If lrColumn.ActiveRole.JoinsValueType IsNot Nothing Then

                                Select Case lrColumn.ActiveRole.JoinsValueType.DataType
                                    Case Is = pcenumORMDataType.NumericAutoCounter
                                        lrProperty.DataType = UMS.DataType.Integer
                                    Case Else
                                        lrProperty.DataType = UMS.DataType.TextVariableLength
                                End Select

                                If lrColumn.ActiveRole.JoinsValueType.DataTypeUsesLength Then
                                    lrProperty.Length = lrColumn.ActiveRole.JoinsValueType.DataTypeLength
                                End If
                            End If

                            '----------------------------------------------
                            'Unique Index
                            Dim larIndex = lrTable.Index.FindAll(Function(x) Not x.IsPrimaryKey)
                            Dim larSingleColumnIndex = larIndex.FindAll(Function(x) x.Column.Count = 1)
                            Dim lbIsSingleColumnUniqueIndexColumn As Boolean = larSingleColumnIndex.FindAll(Function(x) x.Column(0).Id = lrColumn.Id).Count > 0

                            If lbIsSingleColumnUniqueIndexColumn Then

                                If lrProperty.Constraints Is Nothing Then lrProperty.Constraints = New List(Of UMS.Constraint)

                                lrProperty.Constraints.Add(UMS.Constraint.Unique)
                            End If

                            lrTypeDefinition.Properties.Add(lrProperty)

                            'Fact Type Readings
                            Select Case lrTable.FBMModelElement.GetType
                                Case Is = GetType(FBM.FactType)
                                Case Else
                                    'Do checking on FactType of the Column
                                    If lrColumn.FactType.Id = lrTable.FBMModelElement.Id Then
                                        Exit Select
                                    ElseIf lrColumn.FactType.Arity <> 2 Then
                                        Exit Select
                                    End If

                                    If lrProperty.Readings Is Nothing Then lrProperty.Readings = New List(Of String)

                                    'Get the FactTypeReadings of the FactType for the Column
                                    For Each lrFactTypeReading In lrColumn.FactType.FactTypeReading
                                        lrProperty.Readings.Add(lrFactTypeReading.GetReadingText)
                                    Next
                            End Select

                        Next 'Column
#End Region


#Region "Uniqueness Constraints"
                        For Each lrIndex In lrTable.Index.FindAll(Function(x) Not x.IsPrimaryKey And x.Column.Count > 1)

                            Dim lrUniquenessConstraint As New UMS.UniquenessConstraint

                            If lrTypeDefinition.UniquenessConstraints Is Nothing Then lrTypeDefinition.UniquenessConstraints = New List(Of UniquenessConstraint)

                            lrUniquenessConstraint.Name = lrIndex.Name

                            For Each lrColumn In lrIndex.Column
                                lrUniquenessConstraint.Properties.Add(lrColumn.Name)
                            Next

                            lrTypeDefinition.UniquenessConstraints.Add(lrUniquenessConstraint)

                        Next
#End Region

#Region "Foreign Key Relationships"

                        For Each lrRDSRelation In lrTable.ForeignKeyRelationship

                            Dim lrRelationship As New UMS.RelationshipDefinition

                            If lrTypeDefinition.Relationships Is Nothing Then lrTypeDefinition.Relationships = New List(Of RelationshipDefinition)

                            lrRelationship.Name = lrRDSRelation.ResponsibleFactType.Id
                            If lrRDSRelation.ResponsibleFactType.GraphLabel.Count > 0 Then
                                lrRelationship.Name = lrRDSRelation.ResponsibleFactType.GraphLabel(0).Label
                            End If

                            lrRelationship.Source = lrRDSRelation.OriginTable.Name
                            lrRelationship.Target = lrRDSRelation.DestinationTable.Name

                            For Each lrColumn In lrRDSRelation.OriginColumns
                                lrRelationship.From.Add(lrColumn.Name)
                            Next

                            For Each lrColumn In lrRDSRelation.DestinationColumns
                                lrRelationship.To.Add(lrColumn.Name)
                            Next

                            For Each lrFactTypeReading In lrRDSRelation.ResponsibleFactType.FactTypeReading
                                lrRelationship.Readings.Add(lrFactTypeReading.GetReadingText)
                            Next

                            lrTypeDefinition.Relationships.Add(lrRelationship)

                        Next

#End Region


                        larUnifiedModellingSchema.Add(lrTypeDefinition)

                        Next

                        Else

                End If

                Return SaveToString(larUnifiedModellingSchema)

            Catch ex As Exception
                Dim lsMessage As String
                Dim mb As MethodBase = MethodInfo.GetCurrentMethod()

                lsMessage = "Error: " & mb.ReflectedType.Name & "." & mb.Name
                lsMessage &= vbCrLf & vbCrLf & ex.Message
                prApplication.ThrowMessage(lsMessage, pcenumErrorType.Critical, ex.StackTrace,,,,,, ex, False)
            End Try

        End Function

        Public Shared Function BuildDeserializer() As IDeserializer
            Return New DeserializerBuilder() _
            .WithNamingConvention(PascalCaseNamingConvention.Instance) _
            .WithTypeConverter(New DataTypeConverter()) _
            .WithTypeConverter(New ConstraintConverter()) _
            .IgnoreUnmatchedProperties() _
            .Build()
        End Function

        Public Shared Function BuildSerializer() As ISerializer
            Return New SerializerBuilder() _
            .WithNamingConvention(PascalCaseNamingConvention.Instance) _
            .WithTypeConverter(New DataTypeConverter()) _
            .WithTypeConverter(New ConstraintConverter()) _
            .ConfigureDefaultValuesHandling(
                DefaultValuesHandling.OmitNull Or
                DefaultValuesHandling.OmitEmptyCollections) _
            .Build()
        End Function

        ''' <summary>
        ''' Load a UMS schema from a YAML file.
        ''' </summary>
        Public Shared Function LoadFromFile(filePath As String) As List(Of TypeDefinition)
            Dim yaml As String = File.ReadAllText(filePath)
            Return LoadFromString(yaml)
        End Function

        ''' <summary>
        ''' Load a UMS schema from a YAML string.
        ''' </summary>
        Public Shared Function LoadFromString(yaml As String) As List(Of TypeDefinition)
            Return BuildDeserializer().Deserialize(Of List(Of TypeDefinition))(yaml)
        End Function

        ''' <summary>
        ''' Serialise a UMS schema to a YAML string.
        ''' </summary>
        Public Shared Function SaveToString(schema As List(Of TypeDefinition)) As String
            Return BuildSerializer().Serialize(schema)
        End Function

        ''' <summary>
        ''' Serialise a UMS schema to a YAML file.
        ''' </summary>
        Public Shared Sub SaveToFile(schema As List(Of TypeDefinition), filePath As String)
            File.WriteAllText(filePath, SaveToString(schema))
        End Sub

    End Class

End Namespace