package com.github.diosa.entities;

import java.util.Map;

public class Shot {
    public static final int MIN_X = -4;
    public static final int MAX_X = 4;
    public static final double MIN_Y = -3;
    public static final double MAX_Y = 3;
    public static final double MIN_R = 1;
    public static final double MAX_R = 5;

    public static final Map<Double, String> colorMap = Map.of(1.0, "rgb(29,114,58)", 2.0, "rgb(28,48,108)",
            3.0, "rgb(176,23,96)", 4.0, "rgb(173,70,27)", 5.0, "rgb(241,207,14)");
    public static final Map<Double, String> colorAMap = Map.of(1.0, "rgba(29,114,58,0.2)", 2.0, "rgba(28,48,108,0.2)",
            3.0, "rgba(176,23,96,0.2)", 4.0, "rgba(173,70,27,0.2)", 5.0, "rgb(241,207,14,0.2)");

    public void setX(double x) {
        this.x = x;
    }

    public void setY(double y) {
        this.y = y;
    }

    public void setR(double r) {
        this.r = r;
    }

    public void setArea(String area) {
        this.area = area;
    }

    private double x;
    private double y;
    private double r;
    private boolean isInit;
    private boolean valid;
    private String area;
    private String currentTime;
    private double execTime;

    public Shot() {
        isInit = false;
        valid = false;
    }

    public Shot(double x, double y, double r) {
        this.x = x;
        this.y = y;
        this.r = r;
        isInit = true;
        checkValid();
    }

    public void checkValid() {
        if (isInit) {
            valid = (x >= MIN_X && x <= MAX_X &&
                     y >= MIN_Y && y <= MAX_Y &&
                     r >= MIN_R && r <= MAX_R);
        } else {
            valid = false;
        }
    }

    public void checkArea() {
        if (x >= 0 && y >= 0 && x*x + y*y <= r*r/4) {
            area = "Точка попала в четверть круга";
            return;
        }
        if (x < 0 && y >= 0 && x >= (-1)*r/2 && y <= r) {
            area = "Точка попала в прямоугольник";
            return;
        }
        if (x >= 0 && y < 0 && y >= x - r/2) {
            area = "Точка попала в треугольник";
            return;
        }
        area = "Точка не попала в область";
    }

    public double getX() {
        return this.x;
    }

    public double getY() {
        return this.y;
    }

    public double getR() {
        return this.r;
    }

    public boolean isInit() {
        return this.isInit;
    }

    public String getLocalDateTime() {
        return this.currentTime;
    }

    public double getExecTime() {
        return this.execTime;
    }

    public void setLocalDateTime(String localDateTime) {
        this.currentTime = localDateTime;
    }

    public void setExecTime(double execTime) {
        this.execTime = execTime;
    }

    public boolean getValid() {
        return this.valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public String getArea() {
        return this.area;
    }
}
