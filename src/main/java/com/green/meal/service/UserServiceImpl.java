package com.green.meal.service;

import com.green.meal.domain.SearchCondition;
import com.green.meal.domain.UserVO;
import com.green.meal.mapper.DeliveryMapper;
import com.green.meal.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper usermapper;
    private final DeliveryMapper delymapper;

    //회원가입시 user insert랑 dely insert 묶어서 Transaction
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void register(UserVO user){
        try{
            usermapper.insertUser(user);
            user.setUserId("df");
            delymapper.insertDely(user);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public UserVO idDupliCheck(String userId){
        return usermapper.selectUserOne(userId);
    }

    @Override
    public int changePwd(String newPwd, String userId){
        Map map = new HashMap();
        map.put("newPwd",newPwd);
        map.put("userId", userId);
        return usermapper.updateUserPwd(map);
    }

    @Override
    public int changeName(String newName, String userId){
        Map map = new HashMap();
        map.put("newName",newName);
        map.put("userId", userId);
        return usermapper.updateUserName(map);
    }

    @Override
    public int changeEmail(String newEmail, String userId){
        Map map = new HashMap();
        map.put("newEmail",newEmail);
        map.put("userId", userId);
        return usermapper.updateUserEmail(map);
    }

    @Override
    public int changePhone(String newPhone, String userId){
        Map map = new HashMap();
        map.put("newPhone",newPhone);
        map.put("userId", userId);
        return usermapper.updateUserPhone(map);
    }

    @Override
    public int changeAddr(String newAddr, String userId){
        Map map = new HashMap();
        map.put("newAddr", newAddr);
        map.put("userId", userId);
        return usermapper.updateUserAddr(map);
    }
    @Override
    public int deleteUser(String userId){
        return usermapper.deleteUser(userId);
    }

    @Override
    public int deleteNaverUser(String userId){
        return usermapper.deleteNaverUser(userId);
    }

    @Override
    public UserVO userDetail(String userId) {
        return usermapper.selectOne(userId);
    }

    @Override
    public int userWithdraw(String userId) {
        return usermapper.delete(userId);
    }

    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return usermapper.searchResultCnt(sc);
    }

    @Override
    public List<UserVO> getSearchResultPage(SearchCondition sc) throws Exception {
        return usermapper.searchSelectPage(sc);
    }


}
