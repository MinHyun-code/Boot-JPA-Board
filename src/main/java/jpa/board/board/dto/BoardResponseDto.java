package jpa.board.board.dto;

import java.time.LocalDateTime;

import jpa.board.board.entity.Board;
import lombok.Getter;

@Getter
public class BoardResponseDto {

    private Long id; // PK
    private String title; // 제목
    private String content; // 내용
    private String writer; // 작성자
    private int hits; // 조회 수
    private char deleteYn; // 삭제 여부
    private String createdDate; // 생성일
    private LocalDateTime modifiedDate; // 수정일

    public BoardResponseDto(Board entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.content = entity.getContent();
        this.writer = entity.getWriter();
        this.hits = entity.getHits();
        this.deleteYn = entity.getDeleteYn();
        this.createdDate = entity.getCreatedDate();
        this.modifiedDate = entity.getModifiedDate();
    }

}