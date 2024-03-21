' apply_sparse

Sub Main()
    Dim outputPath As String
    Dim fileContent As String
    Dim bric As String
    ' Read the output file.
    outputPath = "/home/speedy/repos/coursework/advanced_EM/projects/test_filter/Model/3D/sparse_" & n & "_" & m & ".txt"
    fileContent = ReadFile(outputPath)
    ReportInformation "Output path: " & outputPath
    ReportInformation "contents of file: "
    ReportInformation "" & fileContent

    Dim rows() As String
    rows = Split(fileContent, vbLf) ' Split the output into rows
    Dim i As Integer
    Dim j As Integer
    For i = LBound(rows) To UBound(rows)
        Dim values() As String
        values = Split(rows(i), " ") ' Split each row into individual values
        For j = LBound(values) To UBound(values)
            If values(j) = "0" Then
                Dim brickName As String
                brickName = "solid" & j & "_" & i
                ReportInformation "disabling brick: " & brickName
                DisableBrick brickName
            End If
        Next j
    Next i


End Sub

Function ReadFile(filePath As String) As String
    Dim fileNo As Integer
    fileNo = FreeFile
    Open filePath For Input As #fileNo
    ReadFile = Input$(LOF(fileNo), fileNo)
    Close #fileNo
End Function


Sub DisableBrick(brickName As String)
    ' Attempt to select the specified brick item
    Dim bSelected As Boolean
    bSelected = SelectTreeItem("Components\top_layer\" & brickName)
    ReportInformation "bSelected: "& bSelected
    ' Check if the selection was successful
    If bSelected Then
        ' If the item was successfully selected, change its group to "disabled"
         ReportInformation "bSelected was successful: " & bSelected
         Group.AddItem "solid$top_layer:"&brickName, "Excluded from Simulation"

    Else
        ' If the item could not be selected, optionally handle the error or report back
        ReportInformation "bSelected was unsuccessful: " & bSelected
    End If
End Sub
