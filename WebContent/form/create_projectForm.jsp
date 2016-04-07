<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Test Site</title>

	<link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css" />

   	<script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
   	<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
   	<script type="text/javascript" src="assets/js/backbone-min.js"></script>
	<script type="text/javascript" src="assets/js/joint.js"></script>
    
<style type="text/css">
.bs-example {
	margin: 20px;
}
</style>

<script type="text/javascript">
	
	var tot_obj = null;
	var completeObj = null;
	var complete_list = new Array();
	var class_check = false;
	var method_check = false;
	var variable_check = false;

	var method_list = null;
	var variable_list = null;
	var class_list = new Array();

	var class_list_obj = null;
	var method_list_obj = null;
	var variable_list_obj = null;

	var tt = new Array();
	var tt2 = new Array();

	var regular_expression = new RegExp("^\\w+$", "gi");
	var regular_expression_start_with_number = new RegExp("[^0-9]");

	function class_trigger(class_name) {
		if (/^[-\w]+$/gi.test(class_name) && !(/\s/g.test(class_name))) {
			method_list = new Array();
			variable_list = new Array();
			class_check = true;
		} else {
			alert(class_name + " is invalid class name. Re-enter class name");
			class_check = false;
			return;
		}
		
		if(check_duplicate(class_name))
		{
			alert(class_name + " is already exist. Please re-enter class name");
			class_check = false;
			return;
		}
		var inputblank = document.getElementById("class_name");
		var class_am = document.getElementsByName("class_am")[0].options[document
				.getElementsByName("class_am")[0].selectedIndex].text;

		var o = new makeClass(class_am, class_name);
		var obj = o.makeClassObj();
		
		class_list.push(obj);
		add_something("inner_class_control", obj.class_name, obj.class_am);
		inputblank.value="";
	}

	function makeClass(class_am, class_name) {
		this.class_am = class_am;
		this.class_name = class_name;
	}
	makeClass.prototype.makeClassObj = function() {
		var obj = {
			class_am : this.class_am,
			class_name : this.class_name,
		};
		return obj;
	};

	function method_trigger(method_name) {

		//console.log("entered name : " + method_name);
		if (!class_check) {
			alert("Enter class name");
			return;
		}
		if (/^[-\w]+$/gi.test(method_name) && !(/\s/g.test(method_name)))
			method_check = true;
		else {
			alert(method_name = " is invalid method name. Re-enter method name");
			method_check = false;
			return;
		}
		
		if(check_duplicate2(method_name))
		{
			alert(method_name + " is already exist. Please re-enter method name");
			method_check = false;
			return;
		}
		var inputblank = document.getElementById("method_name");
		var method_am = document.getElementsByName("method_am")[0].options[document
				.getElementsByName("method_am")[0].selectedIndex].text;
		var method_type = document.getElementsByName("method_type")[0].options[document
				.getElementsByName("method_type")[0].selectedIndex].text;
		var method_modifier = document.getElementsByName("method_modifier")[0].options[document
				.getElementsByName("method_modifier")[0].selectedIndex].text;
		var class_info = document.getElementById('class_name_info').value;
		var o = new makeMethod(method_am, method_type, method_modifier,
				method_name, class_info);
		var obj = o.makeMethodObj();

		method_list.push(obj);

		var test = new makeList(class_info, method_list);
		method_list_obj = test.makeListObj();

		add_something2("inner_method_control", obj.method_name);
		inputblank.value="";
	}

	function makeMethod(method_am, method_type, method_modifier, method_name,
			class_info) {
		this.method_am = method_am;
		this.method_type = method_type;
		this.method_modifier = method_modifier;
		this.method_name = method_name;
		this.class_info = class_info;
	}
	makeMethod.prototype.makeMethodObj = function() {
		var obj = {
			method_am : this.method_am,
			method_type : this.method_type,
			method_modifier : this.method_modifier,
			method_name : this.method_name,
			class_info : this.class_info,
		};
		return obj;
	};

	function makeList(class_name, list) {
		this.class_name = class_name;
		this.list = list;
	}
	makeList.prototype.makeListObj = function() {
		var obj = {
			class_name : this.class_name,
			list : this.list,
		};
		return obj;
	};

	
	function add_something(tableid, cname, cam) {
		var table = document.getElementById(tableid);
		var class_name = cname;
		var rowlen = table.rows.length;
		var row = table.insertRow(rowlen - 1);

		row.insertCell(0).innerHTML = "<input type='button' style='width:100%; height:50px;' id='"+class_name+"' value='"+cam+ " class "+class_name+"' data-toggle='modal' data-target='#class_info' onclick='draw_Method_Variable(id)'; />";
		
	}
	function add_something2(tableid, cname) {
		var table = document.getElementById(tableid);
		var class_name = cname;
		var rowlen = table.rows.length;
		var row = table.insertRow(rowlen - 1);

		row.insertCell(0).innerHTML = "<input type='button' style='width:280px; height:30px;' value='"+class_name+"' data-toggle='modal' data-target='#class_info' onclick='draw_Method_Variable(value)'; />";
		
	}

	function objSelPic(optionId) {
		var objSel = document.getElementById(optionId);
		objSel.options.length = 0;
		for (var i = 0; i < class_list.length; i++) {
			objSel.options.add(new Option(class_list[i].class_name, i));
		}
	}

	function draw_Method_Variable(classname) {
		var num = new Array();
		var class_inform = document.getElementById('class_name_info');
		for (var i = 0; i < method_list.length; i++) {
			if (method_list[i].class_info == classname) {
				num.push(method_list[i].method_name);
			}
		}
		
		class_inform.value = classname;
		
		draw_Table(num, "inner_method_control");

	}
	function draw_Table(temp_array, tableid) {
		var table = document.getElementById(tableid);
		while (table.rows.length > 0) {
			table.deleteRow(0);
		}
		for (var i = 0; i < temp_array.length; i++) {
			table.insertRow(i).insertCell(0).innerHTML = temp_array[i];
		}
	}

	function check_duplicate(class_name){
		var cname = class_name;
		for(var i=0;i<class_list.length;i++)
		{
			if(class_list[i].class_name == cname)
				return true;
		}
		return false;
	}
	function check_duplicate2(method_name){
		var mname = method_name;
		for(var i=0;i<method_list.length;i++)
		{
			if(method_list[i].method_name == mname)
				return true;
		}
		return false;
	}
	///////////////////Create Total Obejct ////////////////////
	//최종 object 만드는 부
	function Create_TotObj() {
		tot_obj = new makeTot(class_list,method_list);
		var fobj = tot_obj.makeTotObj();
		return fobj;
	}

	function makeTot(class_list, method_list) {

		this.class_list = class_list;
		this.method_list = method_list;
	}
	makeTot.prototype.makeTotObj = function() {
		var obj = {

			class_list : this.class_list,
			method_list : this.method_list,
		};
		return obj;
	};
	///////////////////////////////////////////////////////////
	function selected(tableId) {
		var rows = document.getElementById(tableId).getElementsByTagName(
				'tbody')[0].getElementsByTagName('tr');
		return "test1";
	}
	
</script>
<script type="text/javascript">
	function gocreateProject() {
		var form = document.getElementById("projectform");
		form.action = "createproject.do";
		form.submit();
	}
	function completeProjectDetail()
	{
		var cString = "";
		var mString = "";
		var m2String= "";
		var temp = "";
		var obj =Create_TotObj();
		var class_detail = document.getElementById("class_detail");
		var method_detail = document.getElementById("method_detail");
		var method_detail2 = document.getElementById("method_detail2");
		
		for(var i=0;i<obj.class_list.length;i++)
		{
			temp = obj.class_list[i].class_am + " " +obj.class_list[i].class_name + "\n";
			cString = cString + temp;
		}
		class_detail.innerHTML = cString;
		
		for(var i=0;i<obj.method_list.length;i++)
		{
			temp = obj.method_list[i].method_am + " " +obj.method_list[i].method_type + " " +obj.method_list[i].method_modifier+ " " +obj.method_list[i].method_name+ " " +obj.method_list[i].class_info + "\n";
			mString = mString + temp;
		}
		method_detail.innerHTML = mString;
		
		for(var i=0;i<obj.method_list.length;i++)
		{
			temp = obj.method_list[i].method_am + " " +obj.method_list[i].method_type + " " +obj.method_list[i].method_name+ " ( In  " +obj.method_list[i].class_info + "  class ) \n";
			m2String = m2String + temp;
		}
		method_detail2.innerHTML = m2String;
	}
	function gocreateProject2() {
		
		var form2 = document.getElementById("projectform2");
		form2.action = "createproject2.do";
		form2.submit();
	}
	function terms()
	{
		var project_creater = document.getElementById("a").value;
		document.getElementById("project_creator2").value = project_creater;
	}
	function terms2()
	{
		var project_name = document.getElementById("b").value;
		document.getElementById("project_name2").value = project_name;
	}
	function terms3()
	{
		var project_type = document.getElementById("c").value;
		document.getElementById("project_type2").value = project_type;
	}
	function terms4()
	{
		var project_type = document.getElementById("d").value;
		document.getElementById("project_content2").value = project_type;
	}
</script>
<script>
	$(document)
			.ready(
					function() {
						var graph = new joint.dia.Graph;
						var uml = joint.shapes.uml;

						var paper = new joint.dia.Paper({
							el : $('#boxes'),
							width : 1000,
							height : 1000,
							model : graph,
							gridSize : 1
						});

						var rects = [];
						var arrows = [];
						var classes = [];

						$("#addUMLClass")
								.click(
										function() {
											var className = [];
											var classLength = class_list.length;
											for (var i = 0; i < classLength; i++) {
												className[i] = class_list[i].class_name;
												addUMLClass(className[i], i);
											}

											var relations = [ Generalization(
													rects[0], rects[1]) ];
											_.each(relations, function(r) {
												graph.addCell(r);
											});

										});

						function addVariable(i) {

							var variableScope = "vs" + i;
							var variableName = "vn" + i;
							var variableType = "vt" + i;
							var text = variableScope + " " + variableName + ":"
									+ variableType + "\n";

							return text;

						}
						function addMethod(i) {

							var methodAccessModifier = "maasdfasfasdfasdfasdfasdfm"
									+ i;
							var methodName = "mn" + i;
							var methodType = "mt" + i;
							var text = methodAccessModifier + " " + methodName
									+ ":" + methodType + "\n";

							return text;
						}

						function addUMLClass(name, p) {
							var classType = 1; //1:normal, 2: abstract, 3: interface
							var variableNum = 2;
							var methodNum = 3;
							var variable = "";
							var method = "";

							for (var i = 0; i < methodNum; i++) {
								var temp, mMax;
								if (i == 0) {
									temp = addMethod(i).length;
									mMax = addMethod(i).length;
								} else {
									temp = addMethod(i).length;
								}
								if (mMax < temp) {
									mMax = temp;
								}
								method += addMethod(i);
							}

							for (var i = 0; i < variableNum; i++) {
								var temp, vMax;
								if (i == 0) {
									temp = addVariable(i).length;
									vMax = addVariable(i).length;
								} else {
									temp = addVariable(i).length;
								}
								if (vMax < temp) {
									vMax = temp;
								}
								variable += addVariable(0);
							}

							var widthSize = mMax > vMax ? mMax : vMax;
							var heightSize = variableNum > methodNum ? variableNum
									: methodNum;

							if (classType == 3) {
								var c = new uml.Interface(
										{
											position : {
												x : p * 10,
												y : p * 300
											},
											size : {
												width : widthSize * 7,
												height : heightSize * 60
											},
											name : name,
											attributes : [ variable ],
											methods : [ method ],
											attrs : {
												'.uml-class-name-rect' : {
													fill : '#feb662',
													stroke : '#ffffff',
													'stroke-width' : 0.5
												},
												'.uml-class-attrs-rect, .uml-class-methods-rect' : {
													fill : '#fdc886',
													stroke : '#fff',
													'stroke-width' : 0.5
												},
												'.uml-class-attrs-text' : {
													ref : '.uml-class-attrs-rect',
													'ref-y' : 0.5,
													'y-alignment' : 'middle'
												},
												'.uml-class-methods-text' : {
													ref : '.uml-class-methods-rect',
													'ref-y' : 0.5,
													'y-alignment' : 'middle'
												}

											}
										})
							} else if (classType == 2) {
								var c = new uml.Abstract(
										{
											position : {
												x : p * 10,
												y : p * 300
											},
											size : {
												width : widthSize * 7,
												height : heightSize * 60
											},
											name : name,
											attributes : [ variable ],
											methods : [ method ],
											attrs : {
												'.uml-class-name-rect' : {
													fill : '#68ddd5',
													stroke : '#ffffff',
													'stroke-width' : 0.5
												},
												'.uml-class-attrs-rect, .uml-class-methods-rect' : {
													fill : '#9687fe',
													stroke : '#fff',
													'stroke-width' : 0.5
												},
												'.uml-class-methods-text, .uml-class-attrs-text' : {
													fill : '#fff'
												}
											}
										});
							} else {
								var c = new uml.Class(
										{
											position : {
												x : p * 10,
												y : p * 300
											},
											size : {
												width : widthSize * 7,
												height : heightSize * 60
											},
											name : name,
											attributes : [ variable ],
											methods : [ method ],
											attrs : {
												'.uml-class-name-rect' : {
													fill : '#ff8450',
													stroke : '#fff',
													'stroke-width' : 0.5,
												},
												'.uml-class-attrs-rect, .uml-class-methods-rect' : {
													fill : '#fe976a',
													stroke : '#fff',
													'stroke-width' : 0.5
												},
												'.uml-class-attrs-text' : {
													ref : '.uml-class-attrs-rect',
													'ref-y' : 0.5,
													'y-alignment' : 'middle'
												},
												'.uml-class-methods-text' : {
													ref : '.uml-class-methods-rect',
													'ref-y' : 0.5,
													'y-alignment' : 'middle'
												}
											}

										});
							}
							rects.push(c);
							graph.addCells([ c ]);

							return c;
						}
						;

						function Generalization(a, b) {
							var link = new uml.Generalization({
								source : {
									id : a.id
								},
								target : {
									id : b.id
								}
							});

							//	arrows.push(link);
							//	graph.addCells([link]);

							return link;

						}
						;

						function Implementation(a, b) {
							var link = new uml.Implementation({
								source : {
									id : a.id
								},
								target : {
									id : b.id
								}
							});

							//	arrows.push(link);
							//	graph.addCells([link]);
							return link;
						}
						;

						function Aggregation(a, b) {
							var link = new uml.Aggregation({
								source : {
									id : a.id
								},
								target : {
									id : b.id
								}
							});

							//	arrows.push(link);
							//	graph.addCells([link]);

							return link;

						}
						;

						function Composition(a, b) {
							var link = new uml.Composition({
								source : {
									id : a.id
								},
								target : {
									id : b.id
								}
							});

							//	arrows.push(link);
							//	graph.addCells([link]);

							return link;

						}
						;

						$("#addBox")
								.click(
										function() {

											var className = "os";
											var classAccessModifier = "cam";
											var variableScope = "vs";
											var variableName = "vn";
											var variableType = "vt";
											var methodAccessModifier = "maasdfasfasdfasdfasdfasdfm";
											var methodName = "mn";
											var methodType = "mt";

											var text1 = className + " : "
													+ classAccessModifier;
											var text2 = variableScope + " : "
													+ variableName + " : "
													+ variableType;
											var text3 = methodAccessModifier
													+ " : " + methodName
													+ " : " + methodType;
											var text = text1 + "\n" + text2
													+ "\n" + text3;

											var width = text2.length > text3.length ? text2.length
													: text3.length;

											var rect = new joint.shapes.basic.Rect(
													{
														position : {
															x : 100,
															y : 30
														},
														size : {
															width : width * 9,
															height : 50
														},
														attrs : {
															rect : {
																fill : 'blue'
															},
															text : {
																text : text,
																fill : 'white'
															}
														}
													});
											rects.push(rect);
											graph.addCells([ rect ]);
										});

						$("#addArrow").click(function() {
							var link = new joint.shapes.uml.Generalization({
								source : {
									x : 100,
									y : 100
								},
								target : {
									x : 100,
									y : 200
								}
							});

							arrows.push(link);
							graph.addCells([ link ]);

						});
					});
</script>

<script type="text/javascript">
	function capture() {
		var MyDiv1 = document.getElementById('boxes');
		var MyDiv2 = document.getElementById('Myboxes');
		MyDiv2.innerHTML = MyDiv1.innerHTML;

		alert(MyDiv1.innerHTML.toString());

	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var classLength = 2;
		var className = [];
		for (var i = 0; i < classLength; i++) {
			className[i] = "class" + (i + 1);
			addTable(className[i]);
		}
	});

	function addTable(cName) {
		$("#step3md")
				.append(
						"<div class='panel panel-default'><div class='panel-heading'><h4 class='text-center'>"
								+ cName
								+ " <span class='fa fa-edit pull-right bigicon'></span></h4>"
								+ "</div> <div class='panel-body text-center'><div class='col-sm-12'> <section class='panel'>"
								+ " <table class='table table-bordered'> <thead><tr class='active' ><th>Method</th><th>Input Data</th><th>Output Data</th>"
								+ " <th>Content</th> </tr><thead><tbody>"
								+ addTableRow()
								+ " </tbody> </table> </section>  </div> </div></div>");
	}

	function addTableRow() {
		var methodLength = 3;
		var methodName = [];
		var method = "";
		for (var i = 0; i < methodLength; i++) {
			methodName[i] = "method" + (i + 1);

			if (i % 2 == 0) {
				method += "<tr class='success'>   <td rowspan='3'  style = 'text-align: center;'>"
						+ methodName[i]
						+ "</td> <td> <input type = 'text' name='inputData'></td>"
						+ "<td> <input type = 'text' name='outputData'></td>"
						+ "<td rowspan='3'><textarea style=' resize: none;' name='content' COLS=30 ROWS=5 placeholder='explain method'></textarea></td></tr> "
						+ "<tr class='success'><td> <input type = 'text' name='inputData'></td>"
						+ "<td> <input type = 'text' name='outputData'></td></tr><tr class='success'>"
						+ "<td> <input type = 'text' name='inputData'></td>"
						+ "<td> <input type = 'text' name='outputData'></td></tr>"
			} else {
				method += "<tr class='warning'>   <td rowspan='3'>"
						+ methodName[i]
						+ "</td> <td> <input type = 'text' name='inputData'></td>"
						+ "<td> <input type = 'text' name='outputData'></td>"
						+ "<td rowspan='3'><textarea style=' resize: none;' name='content' COLS=30 ROWS=5 placeholder='explain method'></textarea></td></tr> "
						+ "<tr class='warning'><td> <input type = 'text' name='inputData'></td>"
						+ "<td> <input type = 'text' name='outputData'></td></tr><tr class='warning'>"
						+ "<td> <input type = 'text' name='inputData'></td>"
						+ "<td> <input type = 'text' name='outputData'></td></tr>"
			}
		}
		return method;
	}
</script>
</head>
<body style="background-color:#FCFCFB;">

	<!--  <h1 align="center">Create New Project</h1>-->
	<div class="container">
		<div align="center"style="width:1130px; height:80px; margin-top:-20px; margin-left:10px; margin-right:5px">
                <img src="assets/css/images/createprj-banner.jpg" alt=""/>
         </div>

		<!-- Steps Progress and Details - START -->
		<div class="container"
			style="margin-top: 100px; margin-bottom: 100px;">
			<div class="row">
				<div class="progress" id="progress1">
					<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="20"
						aria-valuemin="0" aria-valuemax="100" style="width: 20%;"></div>
					<span class="progress-type">Overall Progress</span> <span
						class="progress-completed">20%</span>
				</div>
			</div>
			<div class="row">
				<div class="row step">
					<div id="div1" class="col-md-3 activestep"
						onclick="javascript: resetActive(event, 0, 'step-1');">
						<span class="fa fa-cloud-download"></span>
						<p>Overview</p>
					</div>
					<div class="col-md-3 "
						onclick="javascript: resetActive(event, 33, 'step-2');">
						<span class="fa fa-pencil"></span>
						<p>Details</p>
					</div>
					<div class="col-md-3"
						onclick="javascript: resetActive(event, 66, 'step-3');">
						<span class="fa fa-refresh"></span>
						<p>Design</p>
					</div>
					<div class="col-md-3"
						onclick="javascript: resetActive(event, 100, 'step-4');">
						<span class="fa fa-dollar"></span>
						<p>Check</p>
					</div>
				</div>
			</div>
			<div class="row setup-content step activeStepInfo" id="step-1">
				<div class="col-xs-12">
					<div class="col-md-12 well text-center">
						<h1>STEP 1</h1>
						<h3 class="underline">Overview</h3>
						<!-- step1 -->
						<section class="projectoverview">
							<form role="form" method="get" id="projectform" >
								<div class="project_creator">
									<label for="project_creator">Project Creator: </label> <input
										type="text" id="a"name="project_creator" placeholder="creater" onchange="terms()">

								</div>
								<div class="project_name">
									<label for="project_name">Project Name: </label> <input
										type="text" id="b" name="project_name" placeholder="length 1-500" onchange="terms2()">
								</div>
								<div class="project_type">
									<label for="project_type">Project Type: </label> <select
										id="c" name="project_type" onchange="terms3()">
										<option value="sorting">Sorting</option>
										<option value="tree">Tree</option>
										<option value="algorithm">Algorithm</option>
										<option value="others">Others</option>
									</select>
								</div>
								<div class="project_content">
									<label for="project_content">Project Content: </label><br />
									<textarea name="project_content" id="d" max_length="900" cols="120"
										rows="10" placeholder="Information(1~900)" onchange="terms4()"></textarea>
								</div>
								<br /> <input type="submit" value="Create" formmethod="get"
									onclick="gocreateProject()"> <input type="submit"
									value="Cancel" formmethod="get" formaction="(% url 'main' %)">
							</form>
						</section>
					</div>
				</div>
			</div>
			<div class="row setup-content step hiddenStepInfo" id="step-2">
				<div class="col-xs-12">
					<div class="col-md-12 well text-center"
						style="background-color: #E4F7BA; height: 500px;">
						<h1>STEP 2</h1>
						<h3 class="underline">Details</h3>
						<!-- step2 -->
						<section class="projectdetail">

							<form action="" method="post">
								<div class="bs-example">
									<div style="height: 300px; float: left; width: 50%;">

										<br>
										<!-- Button HTML (to Trigger Modal) -->
										<a href="#myModal" class="btn btn-lg btn-primary"
											data-toggle="modal"
											style="width: 500px; margin-bottom: 30px; margin-left: -40px;">Create
											Class</a>

										<!-- Create Class PopUp-->
										<div id="myModal" class="modal fade">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal"
															aria-hidden="true">&times;</button>
														<h4 class="modal-title">Create Class</h4>
													</div>
													<div class="modal-body">
														<table id="class_control">
															<tr style="text-align: left";>
																<td><select name="class_am" id="classtest">
																		<option value="public">public</option>
																		<option value="private">private</option>
																		<option value="protected">protected</option>
																		<option value="void"></option>
																</select><input type="text" id="class_name"
																	placeholder="Enter class name"></td>
															</tr>
														</table>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">Close</button>
														<button type="button" class="btn btn-default"
															data-dismiss="modal" value="add class" id="class_add"
															onclick="class_trigger(document.getElementById('class_name').value)"; >Add
															Class</button>

													</div>
												</div>
											</div>
										</div>
										<textarea rows="4" cols="50" readonly
											style="width: 500px; height: 200px; margin-left: -40px;">
										You can create Class in here.
										</textarea>
										<!-- Create Class PopUp-->


									</div>
									<div style="height: 300px; float: right; width: 50%;">
										<h2>Class List</h2>
										<div id="class_div" style="height:240px; background-color: #EAEAEA; overflow:auto;">
											
											<table id="inner_class_control" width="100%" border="1"
												cellspacing="0" cellpadding="0" align="middle"
												onclick="selected('inner_class_control')">


											</table>

										</div>
									</div>

									<div id="class_info" class="modal fade">
										<div class="modal-dialog">
											<div class="modal-content" style="height: 500px;">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-hidden="true">&times;</button>
													<h4 class="modal-title">Class detail information</h4>
												</div>
												<div class="modal-body">
													<div style="height:300px; float:right; width:50%;">
														<div id="method_div" style="background-color: #EAEAEA;">

															<table id="inner_method_control" border="1" width="100%"
																cellspacing="0" cellpadding="0" align="middle">

															</table>

														</div>
													</div>
													<div style="height: 300px; float: left; width: 50%;">

														<table id="method_control">
															<tr style="text-align: left";>
																<input type="text" id="class_name_info" readonly>
																<td> <select name="method_am">

																		<option value="public">public</option>
																		<option value="private">private</option>
																		<option value="protected">protected</option>
																		<option value="void"></option>

																</select> <select name="method_type">

																		<option value="void">void</option>
																		<option value="int">int</option>
																		<option value="double">double</option>

																		<option value="float">float</option>
																		<option value="string">string</option>
																		<option value="char">char</option>

																		<option value="byte">byte</option>
																		<option value="short">short</option>
																		<option value="boolean">boolean</option>

																</select> <select name="method_modifier">

																		<option value="final">final</option>
																		<option value="static">static</option>
																		<option value="abstract">abstract</option>

																		<option value="synchronized">synchronized</option>
																		<option value="void">null</option>

																</select></td>

															</tr>
															<br>

															<tr>
																<td>Method name:<input type="text" id="method_name"
																	placeholder="Enter method name"></td>
															</tr>

															<tr>
																<td><br /></td>
															</tr>



														</table>
														<button type="button" class="btn btn-default"
															value="add method" id="method_add"
															onclick="method_trigger(document.getElementById('method_name').value)"; >Add
															Method</button>


													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
							</form>
						</section>
					</div>
					<br> 
					<button onClick="completeProjectDetail()"; value="Create Project">Create Project</button>
					
					<input type="submit" value="Cancel" formmethod="get" formaction="(% url 'main' %)"><br><br><br>
					<div class="col-md-12 well text-center">

						<h3 class="underline">Draw UML</h3>
						<!-- step2 -->
						<input id="addBox" name="add" type="button" style="cursor: hand" value="add class"> 
						<input id="addUMLClass" name="addUMLClass" type="button" value="addUMLClass"> 
						<input id="addArrow" type="button" style="cursor: hand" value="add Arrow">

						<section id="boxes" class="papers"></section>
						<button onClick="capture()" value="capture">capture</button>
						<section id="Myboxes" class="papers"></section>
					</div>
					
				</div>
			</div>
			<div class="row setup-content step hiddenStepInfo" id="step-3">
				<div class="col-xs-12">
					<div class="col-md-12 well text-center">
						<h1>STEP 3</h1>
						<h3 class="underline">Write Test Case</h3>
						Write Test Case! <small>Write test case for each method!</small>

						<div class="col-md-12" id="step3md"></div>

						<div>
							<center style='margin-bottom: 30px;'>
								<input type="submit" name="submit"> <br />
							</center>
						</div>

					</div>

				</div>
			</div>
			<div class="row setup-content step hiddenStepInfo" id="step-4">
			<form role="form" method="get" id="projectform2">
			
			<input type="hidden" value="" name="project_creator" id="project_creator2">
			<input type="hidden" value="" name="project_name" id="project_name2">
			<input type="hidden" value="" name="project_type" id="project_type2">
			<input type="hidden" value="" name="project_content" id="project_content2">
			
				<div class="col-xs-12" style="height: 500px;">
					<div class="col-md-12 well text-center">
						<h1>STEP 4</h1>
						<h3 class="underline">Done</h3>
						<div style="height: 300px; float: left; width: 50%;">
							<h4 class="underline">Class detail</h4>
							<textarea style="width:350px; height:250px;" name ="class_detail" id="class_detail" readonly>
							</textarea>
						</div>
							
						<div style="height: 300px; float: left; width: 50%;">
							<h4 class="underline">Method detail</h4>
							<textarea style="width:450px; height:250px" name = "method_detail2" id="method_detail2" readonly >
							</textarea>
							<textarea style="display:none; width:450px; height:250px" name = "method_detail" id="method_detail" readonly >
							</textarea>
						</div>
						<button onClick="gocreateProject2()"; value="Create Project">Create Project</button>
					
					<input type="submit" value="Cancel" formmethod="get" formaction="(% url 'main' %)">
					</div>
				</div>
			</form>
			</div>
		</div>
	</div>

	<style>
.hiddenStepInfo {
	display: none;
}

.activeStepInfo {
	display: block !important;
}

.underline {
	text-decoration: underline;
}

.step {
	margin-top: 27px;
}

.progress {
	position: relative;
	height: 25px;
}

.progress>.progress-type {
	position: absolute;
	left: 0px;
	font-weight: 800;
	padding: 3px 30px 2px 10px;
	color: rgb(255, 255, 255);
	background-color: rgba(25, 25, 25, 0.2);
}

.progress>.progress-completed {
	position: absolute;
	right: 0px;
	font-weight: 800;
	padding: 3px 10px 2px;
}

.step {
	text-align: center;
}

.step .col-md-3 {
	background-color: #fff;
	border: 1px solid #C0C0C0;
	border-right: none;
}

.step .col-md-3:last-child {
	border: 1px solid #C0C0C0;
}

.step .col-md-3:first-child {
	border-radius: 5px 0 0 5px;
}

.step .col-md-3:last-child {
	border-radius: 0 5px 5px 0;
}

.step .col-md-3:hover {
	color: #F58723;
	cursor: pointer;
}

.step .activestep {
	color: #F58723;
	height: 100px;
	margin-top: -7px;
	padding-top: 7px;
	border-left: 6px solid #5CB85C !important;
	border-right: 6px solid #5CB85C !important;
	border-top: 3px solid #5CB85C !important;
	border-bottom: 3px solid #5CB85C !important;
	vertical-align: central;
}

.step .fa {
	padding-top: 15px;
	font-size: 40px;
}
</style>

	<script type="text/javascript">
		function resetActive(event, percent, step) {
			$(".progress-bar").css("width", percent + "%").attr(
					"aria-valuenow", percent);
			$(".progress-completed").text(percent + "%");

			$("div").each(function() {
				if ($(this).hasClass("activestep")) {
					$(this).removeClass("activestep");
				}
			});

			if (event.target.className == "col-md-3") {
				$(event.target).addClass("activestep");
			} else {
				$(event.target.parentNode).addClass("activestep");
			}

			hideSteps();
			showCurrentStepInfo(step);
		}

		function hideSteps() {
			$("div").each(function() {
				if ($(this).hasClass("activeStepInfo")) {
					$(this).removeClass("activeStepInfo");
					$(this).addClass("hiddenStepInfo");
				}
			});
		}

		function showCurrentStepInfo(step) {
			var id = "#" + step;
			$(id).addClass("activeStepInfo");
		}
	</script>

	<!—- Steps Progress and Details - END -—>

	</div>

</body>

</html>