package com.ssafy.qna.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.qna.model.QnaDTO;

@Repository
@Mapper
public interface QnaMapper {
	
	List<QnaDTO> getList();
	QnaDTO getQna(int qnaNo);
	int writeQna(QnaDTO qnaDto);
	int modifyQna(QnaDTO qnaDto);
	int deleteQna(int qnaNo);
	int updateHit(int qnaNo);
	int writeAnswer(QnaDTO qnaDto);
	int state(int qnaNo);
}
