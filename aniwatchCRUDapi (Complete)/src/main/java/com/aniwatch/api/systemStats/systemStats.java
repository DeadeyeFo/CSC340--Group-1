package com.aniwatch.api.systemStats;
import jakarta.persistence.*;

@Entity
@Table(name = "statLogs")
public class systemStats {


    @Id
    String date;

    @Column
    String averageLoadTime;

    @Column
    Integer systemTempF;


    public systemStats() {};

    public systemStats(String date, String averageLoadTime, Integer systemTempF) {
        this.date = date;
        this.averageLoadTime = averageLoadTime;
        this.systemTempF = systemTempF;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getAverageLoadTime() {
        return averageLoadTime;
    }

    public void setAverageLoadTime(String averageLoadTime) {
        this.averageLoadTime = averageLoadTime;
    }

    public Integer getSystemTempF() {
        return systemTempF;
    }

    public void setSystemTempF(Integer systemTempF) {
        this.systemTempF = systemTempF;
    }

}
