' this will be the process by which we test for good agreement with the new brick added or removed 
' Still needs to have more work done to get the system done. sParams and Runsimulationandgetsparams need to be implemented
Sub Main()
    Dim outputPath As String
    Dim fileContent As String
    Dim bric As String
    Dim i As Integer
    Dim j As Integer
    Dim s11 As Integer
    Dim s21 As Integer
    
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
            If values(j) = "0" Then  ' This value is 0, meaning we are disabled and should enable brick
                Dim brickName As String
                Dim DisabledBrick As Boolean
                brickName = "solid" & j & "_" & i
                DisabledBrick = True
                ReportInformation "is " & brickName &" Disabled: " & DisabledBrick
                '<if yes, enable and run simulation to get S11 and S21>
                EnableBrick(brickName)
       
                ' Run the simulation and fetch new S11 and S21
                Dim sParams As Object = RunSimulationAndGetSParams()
                Dim currentS11 As Double = sParams("S11")
                Dim currentS21 As Double = sParams("S21")
                ' Decide whether to keep the brick enabled based on S11 and S21
                If currentS11 < bestS11 And currentS21 < bestS21 Then
                    ' If the new configuration is better, update bestS11 and bestS21
                    bestS11 = currentS11
                    bestS21 = currentS21
                    ' Keep the brick enabled as it improves performance
                Else
                    ' If not better, disable the brick again
                    DisableBrick(brickName)
                End If
            Else ' This value is 1, meaning we are enabled and should disable brick
                Dim brickName As String
                Dim DisabledBrick As Boolean
                brickName = "solid" & j & "_" & i
                DisabledBrick = False
                ReportInformation "is " & brickName &" Disabled: " & DisabledBrick
                '<if yes, enable and run simulation to get S11 and S21>
                DisbleBrick brickName       
                ' Run the simulation and fetch new S11 and S21
                Dim sParams As Object = RunSimulationAndGetSParams()
                Dim currentS11 As Double = sParams("S11")
                Dim currentS21 As Double = sParams("S21")
                ' Decide whether to keep the brick enabled based on S11 and S21
                If currentS11 < bestS11 And currentS21 < bestS21 Then
                    ' If the new configuration is better, update bestS11 and bestS21
                    bestS11 = currentS11
                    bestS21 = currentS21
                    ' Keep the brick disabled as it improves performance
                Else
                    ' If not better, enable the brick again
                    EnableBrick(brickName)
                End If
            End If
        Next j
    Next i
End Sub

Sub DisableBrick(brickName As String)
    ' Attempt to select the specified brick item
    Dim bSelected As Boolean
    bSelected = SelectTreeItem("Components\top_layer\\" & brickName)
    ReportInformation "bSelected:" & bSelected
    ' Check if the selection was successful
    If bSelected Then
        ' If the item was successfully selected, change its group to disabled
        ReportInformation "bSelected was successful: " & bSelected
        Group.AddItem "solid$top_layer:"&brickName, "Excluded from Simulation"
    Else
        ' If the item could not be selected, optionally handle the error or report back
        ReportInformation "bSelected was unsuccessful: " & bSelected
    End If
End Sub
	
Sub EnableBrick(brickName As String)
    ' Attempt to select the specified brick item
    Dim bSelected As Boolean
    bSelected = SelectTreeItem("Components\top_layer\\" & brickName)
    ReportInformation "bSelected: "& bSelected
    ' Check if the selection was successful
    If bSelected Then
        ' If the item was successfully selected, change its group to "disabled"
         ReportInformation "bSelected was successful: " & bSelected
         Group.RemoveItem "solid$top_layer:"&brickName, "Excluded from Simulation"
    Else
        ' If the item could not be selected, optionally handle the error or report back
        ReportInformation "bSelected was unsuccessful: " & bSelected
    End If
End Sub
