<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>管理分区</title>
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
		<script type="text/javascript" src="../../js/highcharts/highcharts.js"></script>
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
			
			//导出按钮绑定的事件
			function doExport(){
				
			}
			
			function doImport(){
				alert("导入");
			}
			
			function doShowChart(){
				
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
				id : 'button-import',
				text : '导入',
				iconCls : 'icon-redo',
				handler : doImport
			},{
				id : 'button-export',
				text : '导出',
				iconCls : 'icon-undo',
				handler : doExport
			},{
				id : 'button-showChart',
				text : '分区分布图',
				iconCls : 'icon-search',
				handler : doShowChart
			}];
			// 定义列
			var columns = [ [ {
				field : 'id',
				checkbox : true,
			}, {
				field : 'showid',
				title : '编号',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					return row.id;
				}
			},{
				field : 'area.province',
				title : '省',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					if(row.area != null ){
						return row.area.province;
					}
					return "" ;
				}
			}, {
				field : 'area.city',
				title : '市',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					if(row.area != null ){
						return row.area.city;
					}
					return "" ;
				}
			}, {
				field : 'area.district',
				title : '区',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					if(row.area != null ){
						return row.area.district;
					}
					return "" ;
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
				field : 'assistKeyWords',
				title : '辅助关键字',
				width : 100,
				align : 'center'
			} ] ];
			
			$(function(){
				// 先将body隐藏，再显示，不会出现页面刷新效果
				$("body").css({visibility:"visible"});
				
				// 分区管理数据表格
				$('#grid').datagrid( {
					iconCls : 'icon-forward',
					fit : true,
					border : true,
					rownumbers : true,
					striped : true,
					pageList: [30,50,100],
					pagination : true,
					toolbar : toolbar,
					url : "../../data/sub_area.json",
					idField : 'id',
					columns : columns,
					onDblClickRow : doDblClickRow
				});
				
				// 添加、修改分区
				$('#addWindow').window({
			        title: '添加修改分区',
			        width: 600,
			        modal: true,
			        shadow: true,
			        closed: true,
			        height: 400,
			        resizable:false
			    });
				
				$('#chartWindow').window({
			        width: 700,
			        modal: true,
			        shadow: true,
			        closed: true,
			        height: 600,
			        resizable:false
			    });
				
				// 查询分区
				$('#searchWindow').window({
			        title: '查询分区',
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
			}
		</script>
	</head>

	<body class="easyui-layout" style="visibility:hidden;">
		<div region="center" border="false">
			<table id="grid"></table>
		</div>
		<!-- 添加 修改分区 -->
		<div class="easyui-window" title="分区添加修改" id="addWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
			<div style="height:31px;overflow:hidden;" split="false" border="false">
				<div class="datagrid-toolbar">
					<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
				</div>
			</div>

			<div style="overflow:auto;padding:5px;" border="false">
				<form id="subareaForm" method="post" action="../../subareaAction_save.action">
					<table class="table-edit" width="80%" align="center">
						<tr class="title">
							<td colspan="2">分区信息</td>
						</tr>
						<tr>
							<td>选择区域</td>
							<td>
								<input class="easyui-combobox" name="area.id"
									 data-options="valueField:'id',textField:'name',
									 url:'',editable:false" />
							</td>
						</tr>
						<tr>
							<td>关键字</td>
							<td>
								<input type="text" name="keyWords" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>辅助关键字</td>
							<td>
								<input type="text" name="assistKeyWords" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>起始号</td>
							<td>
								<input type="text" name="startNum" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>终止号</td>
							<td>
								<input type="text" name="endNum" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>位置信息</td>
							<td>
								<input type="text" name="address" class="easyui-validatebox" required="true" style="width:250px;" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		
		<div class="easyui-window" title="分区分布图" id="chartWindow" collapsible="false" 
				minimizable="false" maximizable="false" style="top:20px;left:200px">
			<div id="container"></div>
		</div>
		
		<!-- 查询分区 -->
		<div class="easyui-window" title="查询分区窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
			<div style="overflow:auto;padding:5px;" border="false">
				<form>
					<table class="table-edit" width="80%" align="center">
						<tr class="title">
							<td colspan="2">查询条件</td>
						</tr>
						<tr>
							<td>省</td>
							<td>
								<input type="text" name="province" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>市</td>
							<td>
								<input type="text" name="city" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>区（县）</td>
							<td>
								<input type="text" name="district" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>定区编码</td>
							<td>
								<input type="text" name="decidedzone.id" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td>关键字</td>
							<td>
								<input type="text" name="addresskey" class="easyui-validatebox" required="true" />
							</td>
						</tr>
						<tr>
							<td colspan="2"><a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> </td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</body>

</html>