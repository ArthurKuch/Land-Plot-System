package com.kuch.landsystem.model;

public class Users {

    private int id;
    private String name;
    private String surname;
    private String email;
    private String login;
    private String pass;
    private String phone;
    private String city;

    public Users(){

    }

    @Override
    public String toString() {
        return "Users{" +
                ", name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", login='" + login + '\'' +
                ", phone='" + phone + '\'' +
                ", city='" + city + '\'' +
                '}';
    }

    public Users(String name, String surname, String login, String phone, String city) {
        this.name = name;
        this.surname = surname;
        this.login = login;
        this.phone = phone;
        this.city = city;
    }

    public Users(String name, String surname,int id, String phone, String city) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.phone = phone;
        this.city = city;
    }

    public Users(int id, String name, String surname, String email, String login, String pass, String phone, String city) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.login = login;
        this.pass = pass;
        this.phone = phone;
        this.city = city;
    }

    public Users(String name, String surname, String email, String login, String pass, String phone, String city) {
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.login = login;
        this.pass = pass;
        this.phone = phone;
        this.city = city;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}
