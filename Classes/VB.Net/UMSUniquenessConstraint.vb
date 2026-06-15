Imports YamlDotNet.Serialization
Imports YamlDotNet.Serialization.NamingConventions

Namespace UMS

    Public Class UniquenessConstraint

        ''' <summary>
        ''' FK or relationship name e.g. FK_Session_Cinema, PersonLikesFilm_Person
        ''' </summary>
        Public Property Name As String

        ''' <summary>
        ''' Graph label e.g. IS_AT, IS_FOR, IS_IN
        ''' Optional — relationship types may omit the label on their FK entries
        ''' </summary>
        Public Property Properties As New List(Of String)

    End Class

End Namespace