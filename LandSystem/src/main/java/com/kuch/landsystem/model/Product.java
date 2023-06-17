package com.kuch.landsystem.model;

import javax.servlet.http.Part;

public class Product {
    private int id;
    private String pname;
    private String price;
    private String description;
    private int user_id;
    private Part part;

    public Product(){}

    public Product (String pname, String price, String description,Part part, int user_id) {
        this.pname = pname;
        this.price = price;
        this.description = description;
        this.user_id = user_id;
        this.part = part;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public Part getPart() {
        return part;
    }

    public void setPart(Part part) {
        this.part = part;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", pname='" + pname + '\'' +
                ", price='" + price + '\'' +
                ", description='" + description + '\'' +
                ", user_id=" + user_id +
                ", part=" + part +
                '}';
    }
}
