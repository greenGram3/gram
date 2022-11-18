package com.green.meal.service;

import com.green.meal.domain.SearchCondition;
import com.green.meal.domain.UserVO;

import java.util.List;

public interface UserService {
    int register(UserVO user);

    UserVO idDupliCheck(String userId);

    int changePwd(String newPwd, String userId);

    int changeName(String newName, String userId);

    int changeEmail(String newEmail, String userId);

    int changePhone(String newPhone, String userId);

    int changeAddr(String newAddr, String userId);

    int deleteUser(String userId);

    int deleteNaverUser(String userId);


    UserVO userDetail(String userId) throws Exception;

    int userWithdraw(String userId) throws Exception;

    int getSearchResultCnt(SearchCondition sc) throws Exception;

    List<UserVO> getSearchResultPage(SearchCondition sc) throws Exception;
}
