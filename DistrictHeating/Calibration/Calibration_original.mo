within DistrictHeating.Calibration;
model Calibration_original

  parameter String fileNameStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameOil = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Oil_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Wood_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameStore = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Store.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameTemperature = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNet = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));

  DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=false,
      Qmax=2300000)
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
  DistrictHeating.Components.Boiler.BoilerInFinite Wood(limited_heat=false,
      Qmax=1600000)
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
  DistrictHeating.Components.Boiler.BoilerInFinite Oil(limited_heat=false, Qmax=
       1300000)
    annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperature)                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));

  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  DistrictHeating.Components.Storage.StorageInfinite Store(
    C=137*water.rho*water.cp,
    der_T=0,
    G=1800,
    Tstart(displayUnit="degC") = 300,
    Tref(displayUnit="degC") = 295)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable Net_source(
    tableOnFile=true,
    tableName="Netzleistung",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameNet)                                       annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));

  Modelica.Blocks.Sources.CombiTimeTable Oil_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Oelleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameOil)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-30})));
  Modelica.Blocks.Sources.CombiTimeTable Wood_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Hackgutleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameWood)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Sources.CombiTimeTable Straw_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Strohleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStraw)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,30})));
  Modelica.Blocks.Sources.CombiTimeTable Store_source(
    tableOnFile=true,
    tableName="Speicherenergie",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStore)                                     annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,70})));

  From_Scalar_To_Heat Original_heat
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Blocks.Continuous.Integrator Int_Original_Data(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Continuous.Integrator Int_Prod_Heat(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-70})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,0})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Used_Heat annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  Modelica.Blocks.Continuous.Integrator Int_Used_Heat(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-70})));
  Modelica.Blocks.Continuous.Integrator Int_Store_Losses(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,70})));
equation

Store.Heat_Losses.Q_flow=Int_Store_Losses.u;

  connect(Outside_Temp_source.y[6], Store.outside_temp) annotation (Line(points={{
          7.21645e-016,-19},{0,-19},{0,-10.4}},  color={0,0,127}));
  connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
    annotation (Line(points={{70.6,0},{79,0}},        color={0,0,127}));
  connect(Oil.nominal_heat, Oil_source.y[6])
    annotation (Line(points={{-72.4,-30},{-79,-30}}, color={0,0,127}));
  connect(Wood.nominal_heat, Wood_source.y[6])
    annotation (Line(points={{-72.4,0},{-72.4,0},{-79,0}},
                                                         color={0,0,127}));
  connect(Straw.nominal_heat, Straw_source.y[6])
    annotation (Line(points={{-72.4,30},{-79,30}}, color={0,0,127}));
  connect(Store_source.y[6], Original_heat.u)
    annotation (Line(points={{21,70},{29.4,70}}, color={0,0,127}));
  connect(Original_heat.y, Int_Original_Data.u)
    annotation (Line(points={{50.4,70},{50.4,70},{58,70}}, color={0,0,127}));
  connect(Used_Heat.Q_flow, Int_Used_Heat.u)
    annotation (Line(points={{30,-10},{30,-58}},         color={0,0,127}));
  connect(Produced_heat.port_b, Store.heat_input)
    annotation (Line(points={{-20,0},{-15,0},{-10,0}}, color={191,0,0}));
  connect(Wood.thermal_heat_flow, Produced_heat.port_a)
    annotation (Line(points={{-52,0},{-40,0}}, color={191,0,0}));
  connect(Oil.thermal_heat_flow, Produced_heat.port_a) annotation (Line(
        points={{-52,-30},{-46,-30},{-46,0},{-40,0}}, color={191,0,0}));
  connect(Straw.thermal_heat_flow, Produced_heat.port_a) annotation (Line(
        points={{-52,30},{-46,30},{-46,0},{-40,0}}, color={191,0,0}));
  connect(Store.heat_output, Used_Heat.port_a)
    annotation (Line(points={{10,0},{16,0},{20,0}}, color={191,0,0}));
  connect(Used_Heat.port_b, consumerTimeDependExt.heat_flow)
    annotation (Line(points={{40,0},{50,0}}, color={191,0,0}));
  connect(Produced_heat.Q_flow, Int_Prod_Heat.u)
    annotation (Line(points={{-30,-10},{-30,-58}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=4.134e+006,
      StopTime=2.274e+007,
      Interval=60),
    __Dymola_experimentSetupOutput);
end Calibration_original;
