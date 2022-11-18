package com.green.meal.service;

import com.green.meal.domain.SearchCondition;
import com.green.meal.domain.UserVO;
import com.green.meal.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper mapper;

    @Override
    public int register(UserVO user){
       return mapper.insertUser(user);
    }

    @Override
    public UserVO idDupliCheck(String userId){
        return mapper.selectUserOne(userId);
    }

    @Override
    public int changePwd(String newPwd, String userId){
        Map map = new HashMap();
        map.put("newPwd",newPwd);
        map.put("userId", userId);
        return mapper.updateUserPwd(map);
    }

    @Override
    public int changeName(String newName, String userId){
        Map map = new HashMap();
        map.put("newName",newName);
        map.put("userId", userId);
        return mapper.updateUserName(map);
    }

    @Override
    public int changeEmail(String newEmail, String userId){
        Map map = new HashMap();
        map.put("newEmail",newEmail);
        map.put("userId", userId);
        return mapper.updateUserEmail(map);
    }

    @Override
    public int changePhone(String newPhone, String userId){
        Map map = new HashMap();
        map.put("newPhone",newPhone);
        map.put("userId", userId);
        return mapper.updateUserPhone(map);
    }

    @Override
    public int changeAddr(String newAddr, String userId){
        Map map = new HashMap();
        map.put("newAddr", newAddr);
        map.put("userId", userId);
        return mapper.updateUserAddr(map);
    }
    @Override
    public int deleteUser(String userId){
        return mapper.deleteUser(userId);
    }

    @Override
    public UserVO userDetail(String userId) {
        return mapper.selectOne(userId);
    }

    @Override
    public int userWithdraw(String userId) {
        return mapper.delete(userId);
    }

    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return mapper.searchResultCnt(sc);
    }

    @Override
    public List<UserVO> getSearchResultPage(SearchCondition sc) throws Exception {
        return mapper.searchSelectPage(sc);
    }
}
