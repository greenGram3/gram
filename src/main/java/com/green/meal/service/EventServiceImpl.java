package com.green.meal.service;

import com.green.meal.domain.EventVO;
import com.green.meal.mapper.EventMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@RequiredArgsConstructor
@Service
public class EventServiceImpl implements EventService {

    private final EventMapper mapper;

    @Override
    public List<EventVO> selectEvent(){
        return mapper.selectEvent();
    }

    @Override
    public List<EventVO> selectBanner(){
        return mapper.selectBanner();
    }

    @Override
    public int insertEvent(EventVO eventVO, String realPath) throws Exception{

        realPath += "resources\\eventImage\\";
        MultipartFile fileName = eventVO.getFileName();
        MultipartFile detailImage = eventVO.getDetailImage();
        //대표이미지 저장
        fileName.transferTo(new File(realPath + fileName.getOriginalFilename()));
        //상세이미지 저장
        detailImage.transferTo(new File(realPath + detailImage.getOriginalFilename()));
        //경로 저장
        eventVO.setImgPath("/eventImage/"+fileName.getOriginalFilename());
        eventVO.setImgName("/eventImage/"+detailImage.getOriginalFilename());

        return mapper.insertEvent(eventVO);
    }

    @Override
    public int updateEvent(EventVO eventVO, String realPath) throws Exception{
        realPath += "resources\\eventImage\\";
        MultipartFile fileName = eventVO.getFileName();
        MultipartFile detailImage = eventVO.getDetailImage();

        //새로운 업로드 이미지가 있을때
        if(!fileName.isEmpty()) {
            fileName.transferTo(new File(realPath + fileName.getOriginalFilename()));
            eventVO.setImgPath("/eventImage/"+fileName.getOriginalFilename());
        }
        if(!detailImage.isEmpty()) {
            detailImage.transferTo(new File(realPath + detailImage.getOriginalFilename()));
            eventVO.setImgName("/eventImage/"+detailImage.getOriginalFilename());
        }

        return mapper.updateEvent(eventVO);
    }

    @Override
    public EventVO selectOne(Integer eventNo){
        return mapper.selectOne(eventNo);
    }

    @Override
    public int deleteEvent(Integer eventNo){
        return mapper.deleteEvent(eventNo);
    }
}
