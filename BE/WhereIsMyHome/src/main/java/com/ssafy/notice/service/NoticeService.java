package com.ssafy.notice.service;

import java.util.List;
import java.util.Map;

import com.ssafy.notice.model.NoticeDTO;

public interface NoticeService {
	List<NoticeDTO> listArticle() throws Exception;
	int writeArticle(NoticeDTO noticeDTO) throws Exception;
	NoticeDTO getArticle(int articleNo) throws Exception;
	int modifyArticle(NoticeDTO noticeDTO) throws Exception;
	int deleteArticle(int articleNo) throws Exception;
	int updateHit(int articleNo) throws Exception;
}
