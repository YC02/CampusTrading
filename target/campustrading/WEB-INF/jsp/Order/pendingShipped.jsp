<%--
  Created by IntelliJ IDEA.
  User: yc
  Date: 2019/8/24
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>待发货订单详情页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        /*没有相关订单时*/
        .notOrder{width: 400px;height: 160px;margin-left: auto;margin-right: auto;margin-top: 30px;display: none;}
        .notNode{margin-left: 30px;color: #666666;letter-spacing: 2px;}
        /*需要付款的订单的样式*/
        .pendingShipped{width: 900px;margin-right: auto;margin-left: auto;}
        .pendingShipped h3{width: 100%;text-align: center;font-size: 26px;letter-spacing: 2px;font-family: 华文隶书;margin-top: 20px;}
        .pendingShipped ul{margin-top: 16px;}
        .pendingShipped ul li{width:100%;height: 160px;margin-top: 16px;background: rgba(181,211,233,0.63)}
        .pendingShipped ul li>div{float: left;margin-left: 20px;}
        .pendingShipped ul li>div p{margin-top: 8px;}
        .pendingShipped ul li a{color: #555555;}
        .pendingShipped ul li a:hover{cursor: pointer;color: #ff780e}
        .pendingShipped ul li .pic{margin-left: 6px;}
        .pendingShipped ul li img{width: 150px;height: 150px;margin-top: 5px;}
        .pendingShipped ul li img:hover{cursor: pointer;}
        .pendingShipped ul li .goods{width: 220px;margin-top: 22px;}
        .pendingShipped ul li .price{width: 120px;margin-top: 22px;}
        .pendingShipped ul li .receive{width: 270px;height:142px;margin-top: 16px;overflow: hidden;color: #666666;}
        .pendingShipped ul li .receive p{margin-top: 4px;}
        .pendingShipped ul li .operate button{width: 36px;height: 110px;border-radius: 8px;line-height: 18px;margin-top: 22px;
            white-space: normal;padding: 0 9px;}
    </style>
</head>
<body>
<!--没有订单时-->
<div class="notOrder" id="notOrder">
    <img src="images/none.png" width="150" height="150" alt="没有相关订单">
    <i class="notNode">您还没有相关订单哟</i>
</div>
<!--待发货的订单-->
<div class="pendingShipped" id="pendingShipped">
    <h3>我的待发货的订单</h3>
    <ul id="pendingShippedUl"></ul>
</div>


<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    //获取买家，用户的用户名
    var uName=parent.$("#username").val();
    $.ajax({
        url:"/campustrading/PendingShipped",
        data:{"uName":uName},
        type:"post",
        dataType:"json",
        success:function (data) {
            if(data.length<=0){
                $("#notOrder").show();
                $("#pendingShipped").hide();
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
                        "<p><a>"+goodsDetail.name+"</a></p> <p><a>"+goodsDetail.content+"</a></p> </div>" +
                        " <div class='price'><p>单价:&emsp;￥"+data[i].unitPrice.toFixed(2)+"</p>" +
                        "<p>数量:&emsp;"+data[i].goodsNumber+"</p><p>总价:&emsp;￥"+data[i].totalPrice.toFixed(2)+"</p>" +
                        "</div><div class='receive'><p>收货人姓名:&ensp;"+receive.receiveMan+"</p>" +
                        "<p>收货人电话:&ensp;"+receive.receiveTel+"</p><p>收货人地址:&ensp;"+ receive.receiveAddress+"</p>";
                        if(data[i].buyerNote!=""){
                            payLi+="<p>备注:&ensp;"+data[i].buyerNote+"</p>";
                        }
                    payLi+="</div><div class='operate'><button class='layui-btn layui-btn-normal' onclick='remind()' title='提醒发货'>" +
                        "提醒发货</button></div></li>" ;

                }
                $("#pendingShippedUl").append(payLi);
            }

        }
    });

    /*点击订单里面的提醒发货事件*/
    function remind() {
        layer.msg('已成功提醒发货,卖家会尽快发货',{icon:1,time:1500})
    }
</script>
</body>
</html>
