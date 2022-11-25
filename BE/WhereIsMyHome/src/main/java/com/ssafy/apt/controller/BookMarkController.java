package com.ssafy.apt.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.apt.model.BookMarkDto;
import com.ssafy.apt.service.APTService;

@Controller
@RequestMapping("/bookmark")
public class BookMarkController {
	
	private static final Logger logger = LoggerFactory.getLogger(APTController.class);

	private APTService service;

	@Autowired
	public BookMarkController(APTService service) {
		this.service = service;
	}
	
	@GetMapping("")
	public String mvBookmarkList() {
		return "bookmark";
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<?> bookmarkList(@PathVariable("id") String id) {
		List<BookMarkDto> bookmarklist = null;
		try {
			bookmarklist = service.getBookMarkList(id);
			if (bookmarklist != null && !bookmarklist.isEmpty()) {
				return new ResponseEntity<List<BookMarkDto>>(bookmarklist, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}

		} catch (Exception e) {
			System.out.println("북마크 찾기 실패 : " + e);
			return exceptionHandling(e);
		}
	}
	
	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();
		return new ResponseEntity<String>("Error : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
