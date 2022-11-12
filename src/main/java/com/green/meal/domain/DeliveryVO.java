package com.green.meal.domain;
import lombok.*;

@Getter @Setter @ToString @EqualsAndHashCode @NoArgsConstructor
public class DeliveryVO {
    String userId;
    Integer delyNo;
    String delyPlace;
    String delyAddr;
    String receiver;
    String delyPhone;
}
