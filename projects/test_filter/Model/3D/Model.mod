'# MWS Version: Version 2023.0 - Sep 12 2022 - ACIS 32.0.1 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 1 fmax = 5
'# created = '[VERSION]2023.0|32.0.1|20220912[/VERSION]


'@ use template: Antenna_filter.cfg

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
'set the units
With Units
    .SetUnit "Length", "mm"
    .SetUnit "Frequency", "GHz"
    .SetUnit "Voltage", "V"
    .SetUnit "Resistance", "Ohm"
    .SetUnit "Inductance", "nH"
    .SetUnit "Temperature",  "degC"
    .SetUnit "Time", "ns"
    .SetUnit "Current", "A"
    .SetUnit "Conductance", "S"
    .SetUnit "Capacitance", "pF"
End With

ThermalSolver.AmbientTemperature "0"

'----------------------------------------------------------------------------

'set the frequency range
Solver.FrequencyRange "1", "5"

'----------------------------------------------------------------------------

Plot.DrawBox True

With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With

With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With

' optimize mesh settings for planar structures

With Mesh
     .MergeThinPECLayerFixpoints "True"
     .RatioLimit "20"
     .AutomeshRefineAtPecLines "True", "6"
     .FPBAAvoidNonRegUnite "True"
     .ConsiderSpaceForLowerMeshLimit "False"
     .MinimumStepNumber "5"
     .AnisotropicCurvatureRefinement "True"
     .AnisotropicCurvatureRefinementFSM "True"
End With

With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "6"
End With

With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With

With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With

' change mesh adaption scheme to energy
' 		(planar structures tend to store high energy
'     	 locally at edges rather than globally in volume)

MeshAdaption3D.SetAdaptionStrategy "Energy"

' switch on FD-TET setting for accurate farfields

FDSolver.ExtrudeOpenBC "True"

PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"

With FarfieldPlot
	.ClearCuts ' lateral=phi, polar=theta
	.AddCut "lateral", "0", "1"
	.AddCut "lateral", "90", "1"
	.AddCut "polar", "90", "1"
End With

'----------------------------------------------------------------------------

With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With

With Mesh
     .MeshType "PBA"
End With

'set the solver type
ChangeSolverType("HF Time Domain")

'----------------------------------------------------------------------------

'@ set 3d mesh adaptation properties

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With MeshAdaption3D
    .SetType "Time" 
    .SetAdaptionStrategy "Energy" 
    .MinPasses "2" 
    .MaxPasses "6" 
    .SkipPulses "0" 
    .CellIncreaseFactor "0.7" 
    .WeightE "1.0" 
    .WeightB "1.0" 
    .RefineX "True" 
    .RefineY "True" 
    .RefineZ "True" 
    .ClearStopCriteria
    .AddSParameterStopCriterion "True", "1", "5", "0.02", "1", "True" 
    .Add0DResultStopCriterion "", "0.02", "1", "False" 
End With

'@ define time domain solver parameters

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-60"
     .MeshAdaption "True"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .RunDiscretizerOnly "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ set PBA version

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Discretizer.PBAVersion "2022091223"

'@ define frequency range

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solver.FrequencyRange "1", "5"

'@ define time domain solver parameters

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "True"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .RunDiscretizerOnly "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ define time domain solver acceleration

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Solver 
     .UseParallelization "True"
     .MaximumNumberOfThreads "1024"
     .MaximumNumberOfCPUDevices "8"
     .RemoteCalculation "False"
     .UseDistributedComputing "False"
     .MaxNumberOfDistributedComputingPorts "64"
     .DistributeMatrixCalculation "True"
     .MPIParallelization "False"
     .AutomaticMPI "False"
     .HardwareAcceleration "False"
     .MaximumNumberOfGPUs "1"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"
OnlyConsider0D1DResultsForDC "False"

'@ paste structure data: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Material 
     .Reset 
     .Name "Copper (pure)" 
     .Folder "" 
     .Rho "8930.0"
     .ThermalType "Normal"
     .ThermalConductivity "401.0"
     .SpecificHeat "390", "J/K/kg"
     .DynamicViscosity "0"
     .UseEmissivity "True"
     .Emissivity "0"
     .MetabolicRate "0"
     .VoxelConvection "0"
     .BloodFlow "0"
     .MechanicsType "Isotropic"
     .YoungsModulus "120"
     .PoissonsRatio "0.33"
     .ThermalExpansionRate "17"
     .IntrinsicCarrierDensity "0"
     .FrqType "static"
     .Type "Normal"
     .MaterialUnit "Frequency", "Hz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .Epsilon "1"
     .Mu "1.0"
     .Sigma "5.96e+007"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .FrqType "all"
     .Type "Lossy metal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .MaterialUnit "Temperature", "Kelvin"
     .Mu "1.0"
     .Sigma "5.96e+007"
     .LossyMetalSIRoughness "0.0"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "1", "1", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With 

With Material 
     .Reset 
     .Name "Rogers RO4350B (lossy)" 
     .Folder "" 
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0.69"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .UseEmissivity "True"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .IntrinsicCarrierDensity "0"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .Epsilon "3.66"
     .Mu "1.0"
     .Sigma "0.0"
     .TanD "0.0037"
     .TanDFreq "10.0"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0.0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstSigma"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "1st Order"
     .DispersiveFittingSchemeMu "1st Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With 

With SAT 
     .Reset 
     .FileName "*1.cby" 
     .SubProjectScaleFactor "0.001" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With

'@ delete component: body

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.Delete "body"

'@ delete component: upperLayer

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.Delete "upperLayer"

'@ new component: component1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.New "component1"

'@ define brick: component1:bot_copper

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "bot_copper" 
     .Component "component1" 
     .Material "Copper (pure)" 
     .Xrange "-b_w/2", "b_w/2" 
     .Yrange "-b_h/2", "b_h/2" 
     .Zrange "-t_p", "0" 
     .Create
End With

'@ define brick: component1:solid1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (pure)" 
     .Xrange "-b_w/2", "b_w/2" 
     .Yrange "-b_h/2", "b_h/2" 
     .Zrange "0", "t_d" 
     .Create
End With

'@ change material: component1:solid1 to: Rogers RO4350B (lossy)

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.ChangeMaterial "component1:solid1", "Rogers RO4350B (lossy)"

'@ rename block: component1:solid1 to: component1:rogers_subs

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Rename "component1:solid1", "rogers_subs"

'@ rename component: component1 to: body

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.Rename "component1", "body"

'@ new component: top_layer

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.New "top_layer"

'@ define brick: top_layer:input_trace

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "input_trace" 
     .Component "top_layer" 
     .Material "Copper (pure)" 
     .Xrange "-b_w/2", "-b_w/2 + len_trace" 
     .Yrange " - w_trace/2", "w_trace/2" 
     .Zrange "t_d", "t_d + t_p" 
     .Create
End With

'@ define brick: top_layer:solid1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "top_layer" 
     .Material "Copper (pure)" 
     .Xrange "b_w/2 - len_trace", "b_w/2" 
     .Yrange "- w_trace/2", "+ w_trace/2" 
     .Zrange "t_d", "t_d + t_p" 
     .Create
End With

'@ rename block: top_layer:solid1 to: top_layer:output_trace

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Rename "top_layer:solid1", "output_trace"

'@ define port: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder "test_filter"
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "xmin"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "0", "0"
     .Yrange "-24.982704833333", "64.982704833333"
     .Zrange "-25.017704833333", "26.537704833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label ""
     .Folder "test_filter"
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "xmax"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "w", "w"
     .Yrange "-24.982704833333", "64.982704833333"
     .Zrange "-25.017704833333", "26.537704833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define frequency range

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solver.FrequencyRange "1", "5"

'@ set 3d mesh adaptation properties

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With MeshAdaption3D
    .SetType "Time" 
    .SetAdaptionStrategy "Energy" 
    .MinPasses "2" 
    .MaxPasses "6" 
    .SkipPulses "0" 
    .CellIncreaseFactor "0.7" 
    .WeightE "1.0" 
    .WeightB "1.0" 
    .RefineX "True" 
    .RefineY "True" 
    .RefineZ "True" 
    .ClearStopCriteria
    .AddSParameterStopCriterion "True", "1", "5", "0.02", "1", "True" 
    .Add0DResultStopCriterion "", "0.02", "1", "False" 
End With

'@ define time domain solver acceleration

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Solver 
     .UseParallelization "True"
     .MaximumNumberOfThreads "1024"
     .MaximumNumberOfCPUDevices "8"
     .RemoteCalculation "False"
     .UseDistributedComputing "False"
     .MaxNumberOfDistributedComputingPorts "64"
     .DistributeMatrixCalculation "True"
     .MPIParallelization "False"
     .AutomaticMPI "False"
     .HardwareAcceleration "True"
     .MaximumNumberOfGPUs "1"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"
OnlyConsider0D1DResultsForDC "False"

'@ define excitation signal: default

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Reset 
     .Name "default" 
     .SignalType "Gaussian sine" 
     .ProblemType "High Frequency" 
     .Fmin "1" 
     .Fmax "5" 
     .Create 
End With

'@ define excitation signal: signal1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Reset 
     .Name "signal1" 
     .SignalType "Impulse" 
     .ProblemType "High Frequency" 
     .Create 
End With

'@ modify port: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "1" 
     .Label ""
     .Folder "test_filter"
     .NumberOfModes "4"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "xmin"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "0", "0"
     .Yrange "-24.982704833333", "64.982704833333"
     .Zrange "-25.000204833333", "25.270204833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ modify port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "2" 
     .Label ""
     .Folder "test_filter"
     .NumberOfModes "4"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "xmax"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "80", "80"
     .Yrange "-24.982704833333", "64.982704833333"
     .Zrange "-25.000204833333", "25.270204833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ define excitation signal: signal2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Reset 
     .Name "signal2" 
     .SignalType "User" 
     .ProblemType "High Frequency" 
     .Ttotal "0.2" 
     .MinUserSignalSamples "1000" 
     .Create 
End With

'@ delete excitation signal: signal2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Delete "signal2", "High Frequency" 
End With

'@ delete excitation signal: signal1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Delete "signal1", "High Frequency" 
End With

'@ define excitation signal: default

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Reset 
     .Name "default" 
     .SignalType "Gaussian" 
     .ProblemType "High Frequency" 
     .Fmin "1" 
     .Fmax "5" 
     .Create 
End With

'@ set 3d mesh adaptation properties

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With MeshAdaption3D
    .SetType "Time" 
    .SetAdaptionStrategy "Energy" 
    .MinPasses "2" 
    .MaxPasses "6" 
    .SkipPulses "0" 
    .CellIncreaseFactor "0.7" 
    .WeightE "1.0" 
    .WeightB "1.0" 
    .RefineX "True" 
    .RefineY "True" 
    .RefineZ "True" 
    .ClearStopCriteria
    .AddSParameterStopCriterion "True", "1", "5", "0.02", "1", "True" 
    .Add0DResultStopCriterion "", "0.02", "1", "False" 
End With

'@ define excitation signal: TDR-Pulse

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Reset 
     .Name "TDR-Pulse" 
     .SignalType "User" 
     .ProblemType "High Frequency" 
     .Ttotal "3*1" 
     .MinUserSignalSamples "100" 
     .Create 
End With

'@ delete excitation signal: TDR-Pulse

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Delete "TDR-Pulse", "High Frequency" 
End With

'@ define excitation signal: Gaussian_0-1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With TimeSignal 
     .Reset 
     .Name "Gaussian_0-1" 
     .SignalType "Gaussian sine" 
     .ProblemType "High Frequency" 
     .Fmin "5" 
     .Fmax "15" 
     .Create 
End With

'@ define brick: top_layer:solid1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "top_layer" 
     .Material "Copper (pure)" 
     .Xrange "-w/2", "-w/2 + w/(m)" 
     .Yrange "-h/(2)", "-h/(2) + h/((n))" 
     .Zrange "t_d", "t_d + t_p" 
     .Create
End With

'@ rename block: top_layer:solid1 to: top_layer:unitCell

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Rename "top_layer:solid1", "unitCell"

'@ add items to group: "Excluded from Simulation"

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Group.AddItem "solid$top_layer:unitCell", "Excluded from Simulation"

'@ modify port: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "1" 
     .Label ""
     .Folder "test_filter"
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "xmin"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "0", "0"
     .Yrange "-24.982704833333", "64.982704833333"
     .Zrange "-25.000204833333", "25.270204833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ modify port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "2" 
     .Label ""
     .Folder "test_filter"
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "xmax"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "80", "80"
     .Yrange "-24.982704833333", "64.982704833333"
     .Zrange "-25.000204833333", "25.270204833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ modify port: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "1" 
     .Label ""
     .Folder "test_filter"
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "xmin"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-b_w/2", "-b_w/2"
     .Yrange "-49.982704833333", "49.982704833333"
     .Zrange "-25.000204833333", "25.270204833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ modify port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "2" 
     .Label ""
     .Folder "test_filter"
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "xmax"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "b_w/2", "b_w/2"
     .Yrange "-49.982704833333", "49.982704833333"
     .Zrange "-25.000204833333", "25.270204833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ define time domain solver parameters

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-60"
     .MeshAdaption "True"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .RunDiscretizerOnly "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ define time domain solver acceleration

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Solver 
     .UseParallelization "True"
     .MaximumNumberOfThreads "1024"
     .MaximumNumberOfCPUDevices "8"
     .RemoteCalculation "False"
     .UseDistributedComputing "False"
     .MaxNumberOfDistributedComputingPorts "64"
     .DistributeMatrixCalculation "True"
     .MPIParallelization "False"
     .AutomaticMPI "False"
     .HardwareAcceleration "True"
     .MaximumNumberOfGPUs "1"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"
OnlyConsider0D1DResultsForDC "False"

'@ execute macro: makeAllCells

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
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

'@ execute macro: apply_sparse

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
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

'@ set mesh properties (Hexahedral)

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "20" 
     .Set "StepsPerWaveFar", "20" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "20" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "20" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "6" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "1" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Mesh 
     .ConnectivityCheck "True"
     .UsePecEdgeModel "True" 
     .PointAccEnhancement "0" 
     .TSTVersion "0"
	  .PBAVersion "2022091223" 
     .SetCADProcessingMethod "MultiThread22", "-1" 
     .SetGPUForMatrixCalculationDisabled "False" 
End With

'@ set 3d mesh adaptation properties

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With MeshAdaption3D
    .SetType "Time" 
    .SetAdaptionStrategy "Energy" 
    .MinPasses "2" 
    .MaxPasses "6" 
    .SkipPulses "0" 
    .CellIncreaseFactor "0.7" 
    .WeightE "1.0" 
    .WeightB "1.0" 
    .RefineX "True" 
    .RefineY "True" 
    .RefineZ "True" 
    .ClearStopCriteria
    .AddSParameterStopCriterion "False", "2", "3", "0.02", "1", "True" 
    .Add0DResultStopCriterion "", "0.02", "1", "False" 
End With

'@ define time domain solver acceleration

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Solver 
     .UseParallelization "True"
     .MaximumNumberOfThreads "1024"
     .MaximumNumberOfCPUDevices "8"
     .RemoteCalculation "False"
     .UseDistributedComputing "False"
     .MaxNumberOfDistributedComputingPorts "64"
     .DistributeMatrixCalculation "True"
     .MPIParallelization "False"
     .AutomaticMPI "False"
     .HardwareAcceleration "True"
     .MaximumNumberOfGPUs "1"
End With
UseDistributedComputingForParameters "False"
MaxNumberOfDistributedComputingParameters "2"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"
OnlyConsider0D1DResultsForDC "False"

