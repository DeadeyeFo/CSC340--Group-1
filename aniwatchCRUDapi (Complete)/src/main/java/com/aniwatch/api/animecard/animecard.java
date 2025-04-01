package com.aniwatch.api.animecard;

import jakarta.persistence.*;

@Entity
@Table(name = "animecards")
public class animecard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer cardId;

    @Column
    String name;

    @Column
    String altName;

    @Column
    String imageUrl;
    

    @Column
    String description;

    public animecard(){}

    public Integer getCardId(){
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAltName() {
        return altName;
    }

    public void setAltName(String altName) {
        this.altName = altName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "animecard{" +
                "cardId=" + cardId +
                ", name='" + name + '\'' +
                ", altName='" + altName + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
