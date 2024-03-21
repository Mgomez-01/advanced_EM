' MakeSparse

Sub Main()

    Dim pythonExe As String
    Dim scriptPath As String
    Dim cmdLine As String
    Dim args As String
	Dim outputPath As String
	Dim fileContent As String
    Dim bric As String

    ' Path to the Python executable.
    ' Typically this is just 'python3' on a Linux system,
    ' but it could be a full path like '/usr/bin/python3'.
    pythonExe = "python3"

    ' Path to the Python script.
    ' Change this according to where your Python script is.
    scriptPath = "/home/speedy/repos/coursework/advanced_EM/projects/sparse_gen.py"
    outputPath = "/home/speedy/repos/coursework/advanced_EM/projects/test_filter/Model/3D/sparse_" & m & "_" & n & ".txt"
    ReportInformation "script path: " & scriptPath
    ReportInformation "output path: " & outputPath
    args = " -m " & m & " -n " & n
    ReportInformation "dimensions for grid = " &  m & "X" & n

    ' Form the command line.
    cmdLine = pythonExe & " " & scriptPath & " " & args
    ReportInformation "formatted command: " & cmdLine
    ' Run the command.
    Call Shell(cmdLine, vbNormalFocus)
    ReportInformation "CMD executed. generated files in home/speedy/repos/coursework/advanced_EM/projects/test_filter/Model/3D/"


    ' command has been run and the sparse array is present in the directory. Now we create the brics from that
    ' Read the output file
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
            If values(j) = "1" Then
			' Adjusted ranges for placing each unit cell
            Dim xStart As String
            Dim xEnd As String
            Dim yStart As String
            Dim yEnd As String

            xStart = "-w/2 + ((w)/m) * " & j
            xEnd = "-w/2 + ((w)/m) * " & (j+1)
            yStart = "-h/2 + h/n * " & i
            yEnd = "-h/2 + h/n * " & (i+1)
            ReportInformation "i: " & i & ", j: " & j
        	ReportInformation "xStart:" & xStart
        	ReportInformation "xEnd:" & xEnd
        	ReportInformation "yStart:" & yStart
        	ReportInformation "yEnd:" & yEnd

            '## Merged Block - define brick: top_layer:solid1
            StartVersionStringOverrideMode "2023.0|32.0.1|20220912"
            With Brick
                 .Reset
                 .Name "solid" & i & "_" & j ' Unique name for each brick
                 .Component "top_layer"
                 .Material "Copper (pure)"
                 .Xrange xStart, xEnd
                 .Yrange yStart, yEnd
                 .Zrange "t_d", "t_d + t_p"
                 .Create
            End With
            StopVersionStringOverrideMode
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
