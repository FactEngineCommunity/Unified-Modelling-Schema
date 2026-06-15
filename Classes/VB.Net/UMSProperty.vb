Imports YamlDotNet.Serialization
Imports YamlDotNet.Serialization.NamingConventions

Namespace UMS

    Public Class PropertyDefinition

        ''' <summary>
        ''' The property name e.g. Id, Name, CinemaId
        ''' </summary>
        Public Property Name As String

        ''' <summary>
        ''' Optional alias / role name e.g. "Cinema Name", "Film Title"
        ''' </summary>
        Public Property [Alias] As String

        ''' <summary>
        ''' Data type: Integer, DateTime, TextFixedLength, TextVariableLength
        ''' </summary>
        Public Property DataType As UMS.DataType

        ''' <summary>
        ''' Length for TextFixedLength properties e.g. 100, 200, 1
        ''' Null for all other data types
        ''' </summary>
        Public Property Length As Integer?

        ''' <summary>
        ''' Constraints e.g. [NOT NULL, UNIQUE]
        ''' </summary>
        Public Property Constraints As List(Of UMS.Constraint)

        Public Property Readings As List(Of String)

    End Class

End Namespace