package jpa.board.board.dto;

import java.time.LocalDateTime;

import jpa.board.board.entity.Board;
import lombok.Getter;

@Getter
public class BoardResponseDto {

    private Long id; // PK
    private String title; // ����
    private String content; // ����
    private String writer; // �ۼ���
    private int hits; // ��ȸ ��
    private char deleteYn; // ���� ����
    private String createdDate; // ������
    private LocalDateTime modifiedDate; // ������

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