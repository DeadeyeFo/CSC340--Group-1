package com.aniwatch.aniwatch.admin;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class SystemStats {
    private int totalUsers;
    private int totalProviders;
    private int totalWatchlists;
    private int totalComments;
    private int totalSubscriptions;
    private LocalDateTime lastUpdatedDateTime;
    private String lastUpdated;

    // Daily/weekly activity metrics
    private int newUsersLast24Hours;
    private int newWatchlistsLast24Hours;
    private int commentsLast24Hours;

    // Weekly metrics
    private int newUsersLastWeek;
    private int newWatchlistsLastWeek;
    private int commentsLastWeek;

    public SystemStats() {
        this.lastUpdatedDateTime = LocalDateTime.now();
        this.lastUpdated = lastUpdatedDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public int getTotalProviders() {
        return totalProviders;
    }

    public void setTotalProviders(int totalProviders) {
        this.totalProviders = totalProviders;
    }

    public int getTotalWatchlists() {
        return totalWatchlists;
    }

    public void setTotalWatchlists(int totalWatchlists) {
        this.totalWatchlists = totalWatchlists;
    }

    public int getTotalComments() {
        return totalComments;
    }

    public void setTotalComments(int totalComments) {
        this.totalComments = totalComments;
    }

    public int getTotalSubscriptions() {
        return totalSubscriptions;
    }

    public void setTotalSubscriptions(int totalSubscriptions) {
        this.totalSubscriptions = totalSubscriptions;
    }

    public LocalDateTime getLastUpdatedDateTime() {
        return lastUpdatedDateTime;
    }

    public String getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(LocalDateTime lastUpdatedDateTime) {
        this.lastUpdatedDateTime = lastUpdatedDateTime;
        this.lastUpdated = lastUpdatedDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public int getNewUsersLast24Hours() {
        return newUsersLast24Hours;
    }

    public void setNewUsersLast24Hours(int newUsersLast24Hours) {
        this.newUsersLast24Hours = newUsersLast24Hours;
    }

    public int getNewWatchlistsLast24Hours() {
        return newWatchlistsLast24Hours;
    }

    public void setNewWatchlistsLast24Hours(int newWatchlistsLast24Hours) {
        this.newWatchlistsLast24Hours = newWatchlistsLast24Hours;
    }

    public int getCommentsLast24Hours() {
        return commentsLast24Hours;
    }

    public void setCommentsLast24Hours(int commentsLast24Hours) {
        this.commentsLast24Hours = commentsLast24Hours;
    }

    public int getNewUsersLastWeek() {
        return newUsersLastWeek;
    }

    public void setNewUsersLastWeek(int newUsersLastWeek) {
        this.newUsersLastWeek = newUsersLastWeek;
    }

    public int getNewWatchlistsLastWeek() {
        return newWatchlistsLastWeek;
    }

    public void setNewWatchlistsLastWeek(int newWatchlistsLastWeek) {
        this.newWatchlistsLastWeek = newWatchlistsLastWeek;
    }

    public int getCommentsLastWeek() {
        return commentsLastWeek;
    }

    public void setCommentsLastWeek(int commentsLastWeek) {
        this.commentsLastWeek = commentsLastWeek;
    }
}