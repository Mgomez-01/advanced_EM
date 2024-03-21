' make_all_cells
Sub Main()

    ' Loop through each position in the grid defined by m and n
    Dim i As Integer
    Dim J As Integer

    For i = 0 To m - 1
        For J = 0 To n - 1
            ' Adjusted ranges for placing each unit cell
            Dim xStart As String
            Dim xEnd As String
            Dim yStart As String
            Dim yEnd As String

            xStart = "-w/2 + ((w)/m) * " & i
            xEnd = "-w/2 + ((w)/m) * " & (i+1)
            yStart = "-h/2 + h/n * " & J
            yEnd = "-h/2 + h/n * " & (J+1)
            ReportInformation "i: " & i & ", j: " & J
        	ReportInformation "xStart:" & xStart
        	ReportInformation "xEnd:" & xEnd
        	ReportInformation "yStart:" & yStart
        	ReportInformation "yEnd:" & yEnd

            '## Merged Block - define brick: top_layer:solid1
            StartVersionStringOverrideMode "2023.0|32.0.1|20220912"
            With Brick
                 .Reset
                 .Name "solid" & i & "_" & J ' Unique name for each brick
                 .Component "top_layer"
                 .Material "Copper (pure)"
                 .Xrange xStart, xEnd
                 .Yrange yStart, yEnd
                 .Zrange "t_d", "t_d + t_p"
                 .Create
            End With
            StopVersionStringOverrideMode
        Next J
    Next i
End Sub
