<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>管理定区/调度排班</title>
		<!-- 导入jquery核心类库 -->
		<script type="text/javascript" src="../../js/jquery-1.8.3.js"></script>
		<!-- 导入easyui类库 -->
		<link rel="stylesheet" type="text/css" href="../../js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="../../js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="../../js/easyui/ext/portal.css">
		<link rel="stylesheet" type="text/css" href="../../css/default.css">
		<script type="text/javascript" src="../../js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="../../js/easyui/ext/jquery.portal.js"></script>
		<script type="text/javascript" src="../../js/easyui/ext/jquery.cookie.js"></script>
		<script src="../../js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
		<script type="text/javascript">
			function doAdd(){
				$('#addWindow').window("open");
			}
			
			function doEdit(){
				alert("修改...");
			}
			
			function doDelete(){
				alert("删除...");
			}
			
			function doSearch(){
				$('#searchWindow').window("open");
			}
			
			function doAssociations(){
				$('#customerWindow').window('open');
			}
			
			//工具栏
			var toolbar = [ {
				id : 'button-search',	
				text : '查询',
				iconCls : 'icon-search',
				handler : doSearch
			}, {
				id : 'button-add',
				text : '增加',
				iconCls : 'icon-add',
				handler : doAdd
			}, {
				id : 'button-edit',	
				text : '修改',
				iconCls : 'icon-edit',
				handler : doEdit
			},{
				id : 'button-delete',
				text : '删除',
				iconCls : 'icon-cancel',
				handler : doDelete
			},{
				id : 'button-association',
				text : '关联客户',
				iconCls : 'icon-sum',
				handler : doAssociations
			},{
				id : 'button-association-courier',
				text : '关联快递员',
				iconCls : 'icon-sum',
				handler : function(){
					// 判断是否已经选中了一个定区，弹出关联快递员窗口 
					var rows = $("#grid").datagrid('getSelections');
					if(rows.length==1){
						// 只选择了一个定区
						// 弹出定区关联快递员 窗口 
						$("#courierWindow").window('open');
					}else{
						// 没有选中定区，或者选择 了多个定区
						$.messager.alert("警告","关联快递员,只能（必须）选择一个定区","warning");
					}
				}
			},{
				id : 'button-association2',
				text : '关联分区',
				iconCls : 'icon-sum',
				handler : doAssociations
			}];
			// 定义列
			var columns = [ [ {
				field : 'id',
				title : '编号',
				width : 80,
				align : 'center',
				checkbox:true
			},{
				field : 'fixedAreaName',
				title : '定区名称',
				width : 120,
				align : 'center'
			}, {
				field : 'fixedAreaLeader',
				title : '负责人',
				width : 120,
				align : 'center'
			}, {
				field : 'telephone',
				title : '联系电话',
				width : 120,
				align : 'center'
			}, {
				field : 'company',
				title : '所属公司',
				width : 120,
				align : 'center'
			} ] ];
			
			$(function(){
				// 先将body隐藏，再显示，不会出现页面刷新效果
				$("body").css({visibility:"visible"});
				
				// 定区数据表格
				$('#grid').datagrid( {
					iconCls : 'icon-forward',
					fit : true,
					border : true,
					rownumbers : true,
					striped : true,
					pageList: [30,50,100],
					pagination : true,
					toolbar : toolbar,
					url : "../../fixedAreaAction_pageQuery.action",
					idField : 'id',
					columns : columns,
					onDblClickRow : doDblClickRow
				});
				
				// 添加、修改定区
				$('#addWindow').window({
			        title: '添加修改定区',
			        width: 600,
			        modal: true,
			        shadow: true,
			        closed: true,
			        height: 400,
			        resizable:false
			    });
				
				// 查询定区
				$('#searchWindow').window({
			        title: '查询定区',
			        width: 400,
			        modal: true,
			        shadow: true,
			        closed: true,
			        height: 400,
			        resizable:false
			    });
				$("#btn").click(function(){
					alert("执行查询...");
				});
				
			});
		
			function doDblClickRow(){
				alert("双击表格数据...");
				$('#association_subarea').datagrid( {
					fit : true,
					border : true,
					rownumbers : true,
					striped : true,
					url : "../../data/association_subarea.json",
					columns : [ [{
						field : 'id',
						title : '分拣编号',
						width : 120,
						align : 'center'
					},{
						field : 'province',
						title : '省',
						width : 120,
						align : 'center',
						formatter : function(data,row ,index){
							if(row.area!=null){
								return row.area.province;
							}
							return "";
						}
					}, {
						field : 'city',
						title : '市',
						width : 120,
						align : 'center',
						formatter : function(data,row ,index){
							if(row.area!=null){
								return row.area.city;
							}
							return "";
						}
					}, {
						field : 'district',
						title : '区',
						width : 120,
						align : 'center',
						formatter : function(data,row ,index){
							if(row.area!=null){
								return row.area.district;
							}
							return "";
						}
					}, {
						field : 'addresskey',
						title : '关键字',
						width : 120,
						align : 'center'
					}, {
						field : 'startnum',
						title : '起始号',
						width : 100,
						align : 'center'
					}, {
						field : 'endnum',
						title : '终止号',
						width : 100,
						align : 'center'
					} , {
						field : 'single',
						title : '单双号',
						width : 100,
						align : 'center'
					} , {
						field : 'position',
						title : '位置',
						width : 200,
						align : 'center'
					} ] ]
				});
				$('#association_customer').datagrid( {
					fit : true,
					border : true,
					rownumbers : true,
					striped : true,
					url : "../../data/association_customer.json",
					columns : [[{
						field : 'id',
						title : '客户编号',
						width : 120,
						align : 'center'
					},{
						field : 'name',
						title : '客户名称',
						width : 120,
						align : 'center'
					}, {
						field : 'company',
						title : '所属单位',
						width : 120,
						align : 'center'
					}]]
				});
				
			}
		</script>
	</head>

	<body class="easyui-layout" style="visibility:hidden;">
		<div region="center" border="false">
			<table id="grid"></table>
		</div>
		<div region="south" border="false" style="height:150px">
			<div id="tabs" fit="true" class="easyui-tabs">
				<div title="关联分区" id="subArea" style="width:100%;height:100%;overflow:hidden">
					<table id="association_subarea"></table>
				</div>
				<div title="关联客户" id="customers" style="width:100%;height:100%;overflow:hidden">
					<table id="association_customer"></table>
				</div>
			</div>
		</div>

		<!-- 添加 修改定区 -->
		<div class="easyui-window" title="定区添加修改" id="addWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
			<div style="height:31px;overflow:hidden;" split="false" border="false">
				<div class="datagrid-toolbar">
					<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
					</script>
				</div>
			</div>

			<div style="overflow:auto;padding:5px;" border="false">
				<form id="fixedAreaForm" method="post" action="../../fixedAreaAction_save.action">
					<table class="table-edit" width="80%" align="center">
						<tr class="title">
							<td colspan="2">定区信息</td>
						</tr>
						<tr>
							<td>定区编码</td>
							<td><input type="text" name="id" class="easyui-validatebox"
								required="true" /></td>
						</tr>
						<tr>
							<td>定区名称</td>
							<td><input type="text" name="fixedAreaName"
								class="easyui-validatebox" required="true" /></td>
						</tr>
						<tr>
							<td>负责人</td>
							<td><input type="text" name="fixedAreaLeader"
								class="easyui-validatebox" required="true" /></td>
						</tr>
						<tr>
							<td>联系电话</td>
							<td><input type="text" name="telephone"
								class="easyui-validatebox" required="true" /></td>
						</tr>
						<tr>
							<td>所属公司</td>
							<td><input type="text" name="company"
								class="easyui-validatebox" required="true" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 查询定区 -->
		<div class="easyui-window" title="查询定区窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
			<div style="overflow:auto;padding:5px;" border="false">
				<form>
					<table class="table-edit" width="80%" align="center">
						<tr class="title">
							<td colspan="2">查询条件</td>
						</tr>
						<tr>
							<td>定区编码</td>
							<td>
								<input type="text" name="id" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>所属单位</td>
							<td>
								<input type="text" name="courier.company" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>分区</td>
							<td>
								<input type="text" name="subareaName" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td colspan="2"><a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> </td>
						</tr>
					</table>
				</form>
			</div>
		</div>

		<!-- 关联客户窗口 -->
		<div modal="true" class="easyui-window" title="关联客户窗口" id="customerWindow" collapsible="false" closed="true" minimizable="false" maximizable="false" style="top:20px;left:200px;width: 400px;height: 300px;">
			<div style="overflow:auto;padding:5px;" border="false">
				<form id="customerForm" action="../../fixedAreaAction_assignCustomers2FixedArea.action" method="post">
					<table class="table-edit" width="80%" align="center">
						<tr class="title">
							<td colspan="3">关联客户</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" name="id" id="customerFixedAreaId" />
								<select id="noassociationSelect" multiple="multiple" size="10"></select>
							</td>
							<td>
								<input type="button" value="》》" id="toRight">
								<br/>
								<input type="button" value="《《" id="toLeft">
							</td>
							<td>
								<select id="associationSelect" name="customerIds" multiple="multiple" size="10"></select>
							</td>
						</tr>
						<tr>
							<td colspan="3"><a id="associationBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">关联客户</a> </td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		
		<!-- 关联快递员窗口 -->
		<div class="easyui-window" title="关联快递员窗口" id="courierWindow" modal="true"
			collapsible="false" closed="true" minimizable="false" maximizable="false" style="top:20px;left:200px;width: 700px;height: 300px;">
			<div style="overflow:auto;padding:5px;" border="false">
				<form id="courierForm" 
					action="../../fixedAreaAction_associationCourierToFixedArea.action" method="post">
					<table class="table-edit" width="80%" align="center">
						<tr class="title">
							<td colspan="2">关联快递员</td>
						</tr> 
						<tr>
							<td>选择快递员</td>
							<td>
								<!-- 存放定区编号 -->
								<input type="hidden" name="id" id="courierFixedAreaId" />
								<input data-options="ditable:false, url:'../../courierAction_listajax.action',valueField:'id',textField:'name'"
									 type="text" name="courierId" class="easyui-combobox" required="true" />
							</td>
						</tr>
						<tr>
							<td>选择收派时间</td>
							<td>
								<select required="true" class="easyui-combobox" name="takeTimeId">
									<option>请选择</option>
									<option value="1">北京早班</option>
									<option value="2">北京晚班</option>
								</select>
								<!-- <input type="text" name="takeTimeId" class="easyui-combobox" required="true" /> -->
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<a id="associationCourierBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">关联快递员</a>
							 </td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</body>

</html>