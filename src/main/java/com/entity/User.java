package com.entity;

/**
 * @author yc
 * 用户实体类，与数据库的字段对应，封装类
 */

public class User {
    private int id; //id 编号
    private String username;
    private String password;
    private int age;
    private int sex;  //sex，性别 0为女,1为男
    private String phone;
    private String email;
    private String address;
    private int permissions;  //用户权限 0为管理员,1为普通用户，2为卖家，默认为1，不同的权限可到不同的页面

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getPermissions() {
        return permissions;
    }

    public void setPermissions(int permissions) {
        this.permissions = permissions;
    }
}

