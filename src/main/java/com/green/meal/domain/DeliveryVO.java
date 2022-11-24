package com.green.meal.domain;
import lombok.*;

 @NoArgsConstructor
@Data
public class DeliveryVO {
    String userId;
    Integer delyNo;
    String delyPlace;
    String delyAddr;
    String receiver;
    String delyPhone;

}
