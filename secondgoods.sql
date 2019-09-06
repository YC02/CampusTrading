#创建用户信息表
CREATE TABLE IF NOT EXISTS user(
id int PRIMARY key auto_increment COMMENT '用户id',
username VARCHAR(30) COMMENT '用户名',
password VARCHAR(30) COMMENT '密码',
age int COMMENT '用户年龄',
sex int COMMENT '性别，1表示男，0表示女' CHECK(sex=0 or sex=1),
phone VARCHAR(11) NOT NULL COMMENT '联系方式',
email VARCHAR(30) COMMENT '邮箱',
address VARCHAR(30) COMMENT '详细地址',
permissions int DEFAULT 1 COMMENT '用户权限:0为管理员,1为普通用户，2为卖家，默认为1' CHECK(permissions=0 or permissions=1 or permissions=2)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#INSERT into user(username,password,sex,phone,email,permissions) VALUES('user','user',1,'15797863227','1654267800@qq.com',1),('admin','admin',1,'15797863227','1654267800@qq.com',0);

#创建商品表
CREATE TABLE IF NOT EXISTS goods(
g_id int PRIMARY key auto_increment COMMENT '商品id',
name VARCHAR(30) COMMENT '商品名',
price DOUBLE COMMENT '商品价格',
number int COMMENT '商品库存',
type_id INT COMMENT '商品类型id',
content VARCHAR(30) COMMENT '商品信息的简单描述',
picture VARCHAR(30) COMMENT '商品图片的位置',
u_id int COMMENT '卖家ID'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#insert into goods(name,price,number,type_id,content,picture,u_id) values('自行车',119,1,4,'买了1个月，无损伤，八成新。','images/goods_pic/bicycle.jpg',1);

#创建商品类型表
CREATE TABLE IF NOT EXISTS goods_type(
id int PRIMARY key auto_increment COMMENT '商品类型id',
name VARCHAR(30) COMMENT '类型名'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#INSERT INTO goods_type(name) VALUES('课本'),('学习用品'),('电器'),('日常用品'),('衣物');

#创建商品的评价表
CREATE TABLE IF NOT EXISTS evaluate(
id int PRIMARY key auto_increment COMMENT '商品评价id',
gid int COMMENT '商品id',
uname VARCHAR(30) COMMENT '评价标题',
content VARCHAR(300) COMMENT '评价内容',
score int COMMENT '评价数量' DEFAULT 0,
eTime datetime COMMENT '评价时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#创建订单表
CREATE TABLE IF NOT EXISTS orders(
oid int PRIMARY key auto_increment COMMENT '订单id',
sName VARCHAR(30) COMMENT '订单名字',
uName VARCHAR(30) COMMENT '买家名字',
receiveId int COMMENT '收货地址Id',
gid int COMMENT '商品id',
unitPrice DOUBLE COMMENT '单价',
totalPrice DOUBLE COMMENT '总价',
buyerNote VARCHAR(300) COMMENT '买家备注',
goodsNumber int COMMENT '买卖数量',
state int COMMENT '订单的状态，1创建成功,2付款成功，3正在发货，4交易成功，0交易未成功订单取消' CHECK(state=0 or state=1 or state=2 or state=3 or state=4 or state=5),
createTime datetime COMMENT '下单时间',
shipTime datetime COMMENT '发货时间',
clinchTime datetime COMMENT '成交时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#创建用户的收货地址信息表
CREATE TABLE IF NOT EXISTS receive(
id int PRIMARY key auto_increment COMMENT '用户id',
username VARCHAR(30) COMMENT '用户姓名',
receiveMan VARCHAR(30) COMMENT '收货人',
receiveAddress VARCHAR(30) COMMENT '收货地址',
receiveTel VARCHAR(11) COMMENT '收货人联系方式',
isDefault int COMMENT '设置默认地址' DEFAULT 0
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#创建购物车表
CREATE TABLE IF NOT EXISTS shoppingcart(
cid int PRIMARY key auto_increment COMMENT '购物车id',
uName VARCHAR(30) COMMENT '用户姓名',
gid int COMMENT '商品id',
addTime datetime COMMENT '添加时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#创建公告信息表
CREATE TABLE IF NOT EXISTS notice(
id int PRIMARY key auto_increment COMMENT '公告id',
title VARCHAR(30) COMMENT '公告标题',
content VARCHAR(30) COMMENT '公告内容',
createTime datetime COMMENT '公告发布时间',
state VARCHAR(30) COMMENT '公告状态'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;