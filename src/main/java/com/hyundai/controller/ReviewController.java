package com.hyundai.controller;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hyundai.domain.PageDTO;
import com.hyundai.domain.ReviewVO;
import com.hyundai.service.ReviewService;
import com.hyundai.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * @packageName		: com.hyundai.controller
 * @fileName		: ReviewController.java
 * @author			: 정예성 
 * @description		: DB에 저장된 상품평 목록들을 출력하고 상품평 등록, 수정, 삭제 기능을 동작하는 컨트롤러
 */
@Log4j
@RequestMapping("/review/*")
@Controller
@AllArgsConstructor
public class ReviewController {
	
	private ReviewService reviewService; 
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// 리뷰 목록 조회
	@GetMapping("/productReview")
	public void getReviewList(@RequestParam("pageNum") int pageNum, @RequestParam("amount") int amount, @RequestParam("pId") int pId, Model model) {
		
		log.info("reviewList");
		int total = reviewService.getReviewCount(pId, pageNum, 10);
		
		model.addAttribute("reviewList", reviewService.getReviewList(pId, pageNum, amount));
		model.addAttribute("pageMaker", new PageDTO(pageNum, 10, total));
		
	}
	
	// 리뷰 등록
	@PostMapping("/reviewInsert")
	public String create(ReviewVO vo, MultipartFile file, RedirectAttributes rttr) throws Exception {
		
		log.info("ReviewVO: " + vo);
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";  // 이미지를 업로드할 폴더를 설정 = /uploadPath/imgUpload
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);  // 위의 폴더를 기준으로 연월일 폴더를 생성
	    String fileName = null;  // 기본 경로와 별개로 작성되는 경로 + 파일이름
		
	    log.info("file=========================" + file);
	    if(file != null) {
		  // 파일 인풋박스에 첨부된 파일이 없다면(=첨부된 파일이 이름이 없다면)
		  
	    	fileName =  UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		  
	    	vo.setRImage(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
	    	vo.setRThumImage(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);	 

	    	log.info("첨부된 파일이 있음");
		  
		 } else {  // 첨부된 파일이 없으면
			 
		  fileName = File.separator + "images" + File.separator + "none.png";
		  
		  log.info("첨부된 파일 없음");
		  // 미리 준비된 none.png파일을 대신 출력함
		  vo.setRImage(fileName);
		  vo.setRThumImage(fileName);
		 }
	    
		
		reviewService.insertReview(vo);
		
		rttr.addFlashAttribute("result", vo.getRNo());
		
		int pId = vo.getPId();
		
		return "redirect:/review/productReview?pId="+pId+"&pageNum=1&amount=10";
	}
	
	@GetMapping("/reviewInsert")
	public void create(@RequestParam("pId") int pId, @RequestParam("pName") String pName) {
	}
	
	// 리뷰 삭제 
	@GetMapping("/remove")
	public String remove(@RequestParam("rNo") int rNo, RedirectAttributes rttr, @RequestParam("pId") int pId) {
		
		if(reviewService.deleteReview(rNo)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/review/productReview?pId="+pId+"&pageNum=1&amount=10";
	}
	
	// 리뷰 수정
	@PostMapping("/modify")
	public String modify(ReviewVO vo, MultipartFile file, RedirectAttributes rttr, HttpServletRequest req, @RequestParam("pId") int pId) throws Exception{
		
		log.info("vo: " + vo);
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";  // 이미지를 업로드할 폴더를 설정 = /uploadPath/imgUpload
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);  // 위의 폴더를 기준으로 연월일 폴더를 생성
	    String fileName = null;  // 기본 경로와 별개로 작성되는 경로 + 파일이름
		
	    log.info("file=========================" + file);
	    if(file != null) {
		  // 파일 인풋박스에 첨부된 파일이 없다면(=첨부된 파일이 이름이 없다면)
		  
	    	fileName =  UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		  
	    	vo.setRImage(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
	    	vo.setRThumImage(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);	 

	    	log.info("첨부된 파일이 있음");
		  
		 } else {  // 첨부된 파일이 없으면
			 
		  fileName = File.separator + "images" + File.separator + "none.png";
		  
		  log.info("첨부된 파일 없음");
		  // 미리 준비된 none.png파일을 대신 출력함
		  vo.setRImage(req.getParameter("rImage"));
		  vo.setRThumImage(req.getParameter("rThumImage"));
		 }
		
		reviewService.updateReview(vo);
		
		return "redirect:/review/productReview?pId="+pId+"&pageNum=1&amount=10";
	}
	
	@GetMapping("/reviewModify")
	public void get(@RequestParam("rNo") int rNo, @RequestParam("pId") int pId, Model model) {
		
		model.addAttribute("review", reviewService.readReview(rNo));
	}
}
