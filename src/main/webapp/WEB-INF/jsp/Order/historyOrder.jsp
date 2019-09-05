<%--
  Created by IntelliJ IDEA.
  User: yc
  Date: 2019/9/3
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>历史订单详情页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goodsDetail.css">
    <style>
        /*没有相关订单时*/
        .notOrder{width: 400px;height: 160px;margin-left: auto;margin-right: auto;margin-top: 30px;display: none;}
        .notOrder{margin-left: 24px;color: #666666;letter-spacing: 2px;}
        /*历史订单的样式*/
        .historyOrder{width: 740px;margin-right: auto;margin-left: auto;}
        .historyOrder h3{width: 100%;text-align: center;font-size: 26px;letter-spacing: 2px;font-family: 华文隶书;margin-top: 20px;}
        .historyOrder ul{margin-top: 16px;}
        .historyOrder ul li{width:100%;height: 160px;margin-top: 16px;background: rgba(181,211,233,0.63)}
        .historyOrder ul li>div{float: left;margin-left: 20px;}
        .historyOrder ul li>div p{margin-top: 8px;}
        .historyOrder ul li a{color: #555555;}
        .historyOrder ul li a:hover{cursor: pointer;color: #ff780e}
        .historyOrder ul li img{width: 170px;height: 150px;margin-top: 5px;}
        .historyOrder ul li img:hover{cursor: pointer;}
        .historyOrder ul li .operate button{margin-top: 10px;margin-top: 50px;font-size: 16px;border-radius: 20px;}
        .evaluate textarea{width: 320px;height: 120px;resize: none;border: #b7fffa 1px solid;}
    </style>

</head>
<body>
<!--没有订单时-->
<div class="notOrder" id="notOrder">
    <img src="images/none.png" width="150" height="150" alt="没有相关订单">
    <i class="notNode">您还没有相关订单哟</i>
</div>
<!--历史订单-->
<div class="historyOrder" id="historyOrder">
    <h3>我的历史订单</h3>
    <ul id="historyOrderUl"></ul>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    //获取买家，用户的用户名
    var uName=parent.$("#username").val();
    //请求待评价的订单
    $.ajax({
        url:"/campustrading/HistoryOrder",
        data:{"uName":uName},
        type:"post",
        dataType:"json",
        success:function (data) {
            if(data.length<=0){
                $("#notOrder").show();
                $("#historyOrder").hide();
            }
            else {
                var payLi="";
                for(var i=0;i<data.length;i++){
                    //获取商品Id,来获取商品的具体信息
                    var gid=data[i].gId;
                    var goodsDetail=null;
                    $.ajax({
                        url:"/campustrading/GetGoodsDetail",
                        data:{"gid":gid},
                        type:"post",
                        async:false,
                        dataType:"json",
                        success:function (res) {
                            goodsDetail=res;
                        }
                    });
                    //获取收货人姓名，地址的id来查询收货地址的详情
                    var receiveId=data[i].receiveId;
                    var receive=null;
                    $.ajax({
                        url:"/campustrading/QueryAddressById",
                        data:{"id":receiveId},
                        type:"post",
                        async:false,
                        dataType:"json",
                        success:function (ref) {
                            receive=ref;
                        }
                    });
                    payLi+="<li><div class='pic'><img src='"+goodsDetail.picture+"'> </div><div class='goods'>" +
                        "<p><a title='"+goodsDetail.name+"'>"+goodsDetail.name+"</a></p> <p><a title='"+goodsDetail.content+"'>"+goodsDetail.content+"</a></p> </div>" +
                        " <div class='price'><p>单价:&emsp;￥"+data[i].unitPrice.toFixed(2)+"</p>" +
                        "<p>数量:&emsp;"+data[i].goodsNumber+"</p><p>总价:&emsp;￥"+data[i].totalPrice.toFixed(2)+"</p>" +
                        "</div><div class='operate'><button class='layui-btn layui-btn-radius layui-btn-warm' " +
                        "id='oneMore' title='再来一单'>再来一单</button></div> </li>";

                }
            }
            $("#historyOrderUl").append(payLi);
        }
    });

</script>
</body>
</html>
