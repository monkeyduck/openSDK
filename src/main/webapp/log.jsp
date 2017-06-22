<%--
  Created by IntelliJ IDEA.
  User: llc
  Date: 16/6/30
  Time: 下午2:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String ipAddress = request.getScheme()+"://"+request.getServerName()+":";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <title>openSDK Log</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.5/css/bootstrap-select.min.css">


    <!-- DatePicker-->
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css"/>

    <%--引入Vue.js--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/1.0.13/vue.js"></script>

    <style type="text/css">
        .divcss5{
            border-style:solid;
            border-width:1px;
            border-color:#000}
        .divmessage {
            display: block;
            width: 100%;
            /*height: 34px;*/
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        }
    </style>
</head>

<body>
<header>
    <div class="container" style="text-align: center">
        <h3>openSDK 日志</h3>
    </div>
</header>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-1 vcenter"></div>
        <div class="col-md-7 vcenter">
            <div style="float: left">
                <input type="text" class="form-control" name="dateRangeBegin" id="dateRangeBegin"/>
            </div>

            <div style="float: left">
                <select class="selectpicker" data-width="100%" id="envSelect">
                    <option value="xiaole-alpha">小乐-alpha</option>
                    <option value="xiaole-release">小乐-release</option>
                    <option value="beiwa-alpha">贝瓦-alpha</option>
                    <option value="beiwa-beta">贝瓦-beta</option>
                    <option value="beiwa-release">贝瓦-release</option>
                </select>
            </div>



           <div>
               <input id="member_id" type="text" class="form-control"
                      placeholder="输入要查询的member id"/>

           </div>

            <div>
                <input id="device_id" type="text" class="form-control"
                       placeholder="输入要查询的device id"/>

            </div>
            <div style="float: left">
                <button type="button" onclick="displayLog()" class="btn btn-default">显示简单日志</button>

            </div>
            <div style="float:left">
                <button type="button" onclick="simpleDownload()" class="btn btn-default">下载简单日志</button>

            </div>
            <div style="float:left">
                <button type="button" onclick="complexDownload()" class="btn btn-default">下载复杂日志</button>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-md-1 vcenter"></div>
        <div class="col-md-8 vcenter" >
            <div class="divmessage" id="message" style="height:500px; overflow:scroll;">

            </div>

        </div>
    </div>
</div>
</body>

<%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>--%>
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.5/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>

<script type="text/javascript">

    $(document).ready(function() {
        $('.selectpicker').selectpicker();
        var startDate = new Date()
        var endDate = startDate
        var dateRangeBegin = $('input[name="dateRangeBegin"]')
        dateRangeBegin.daterangepicker({
            startDate: startDate,
            singleDatePicker: true,
            "maxDate": endDate,
            showDropdowns: true,
            locale: {
                format: 'YYYY-MM-DD'
            }
        });
    });
    function displayLog() {
        var member_id = document.getElementById('member_id').value;
        var device_id = document.getElementById('device_id').value;
        var date = document.getElementById('dateRangeBegin').value;
        var segs = document.getElementById('envSelect').value.split("-");
        var src = segs[0];
        var env = segs[1];
        if (member_id != "") {
            $.ajax({
                type: "GET",
                url: "/opensdk/realtime-memberId",
                data: "date="+date+"&memberId="+member_id+"&env="+env+"&source="+src,
                success: function (data) {
                    var arr = data.split(",");
                    var ret = "";
                    for (var i = 0; i < arr.length; i++) {
                        ret += "<p>" + arr[i].substr(1,arr[i].length-2) + "</p>";
                    }
                    $("#message").html(ret);
                }
            });
        } else if (device_id != "") {
            $.ajax({
                type: "GET",
                url: "/opensdk/realtime-deviceId",
                data: "date="+date+"&deviceId="+device_id+"&env="+env+"&source="+src,
                success: function (data) {
                    var arr = data.split(",");
                    var ret = "";
                    for (var i = 0; i < arr.length; i++) {
                        ret += "<p>" + arr[i].substr(1,arr[i].length-2) + "</p>";
                    }
                    $("#message").html(ret);
                }
            });
        } else {
            alert("请输入memberId或deviceId");
            return;
        }

    }
    function simpleDownload() {
        var member_id = document.getElementById('member_id').value;
        var device_id = document.getElementById('device_id').value;
        var date = document.getElementById('dateRangeBegin').value;
        var segs = document.getElementById('envSelect').value.split("-");
        var src = segs[0];
        var env = segs[1];
        if (member_id == "") {
            member_id = "all";
        }
        if (device_id == "") {
            device_id = "all";
        }
        window.location.href = '<%=ipAddress%>8081/log/download-simple/date?date='+date+'&memberId='+member_id
                +'&deviceId='+device_id+'&env='+env+'&source='+src;
    }

    function complexDownload() {
        var member_id = document.getElementById('member_id').value;
        var device_id = document.getElementById('device_id').value;
        var date = document.getElementById('dateRangeBegin').value;
        var segs = document.getElementById('envSelect').value.split("-");
        var src = segs[0];
        var env = segs[1];
        if (member_id=="") {
            member_id = "all";
        }
        window.location.href = '<%=ipAddress%>8081/log/download/date?date='+date+'&memberId='+member_id+'&deviceId='
                + device_id+'&env='+env+'&source='+src;
    }

</script>
</html>
