package com.github.diosa.entities;

public class Shot {
    public static final int MIN_X = -4;
    public static final int MAX_X = 4;
    public static final double MIN_Y = -3;
    public static final double MAX_Y = 3;
    public static final double MIN_R = 1;
    public static final double MAX_R = 5;

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

    private void checkValid() {
        if (isInit) {
            valid = (x >= MIN_X && x <= MAX_X &&
                     y >= MIN_Y && y <= MAX_Y &&
                     r >= MIN_R && r <= MAX_R);
        } else {
            valid = false;
        }
    }

    public void checkArea() {
        if (x >= 0 && y >= 0 && x*x + y*y <= r/2) {
            area = "Точка попала в четверть круга";
            return;
        }
        if (x < 0 && y >= 0 && x >= (-1)*r/2) {
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
