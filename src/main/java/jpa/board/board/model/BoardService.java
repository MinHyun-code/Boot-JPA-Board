package jpa.board.board.model;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jpa.board.board.dto.BoardRequestDto;
import jpa.board.board.dto.BoardResponseDto;
import jpa.board.board.entity.Board;
import jpa.board.board.entity.BoardRepository;
import jpa.board.board.exception.CustomException;
import jpa.board.board.exception.ErrorCode;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardRepository boardRepository;

    /**
     * �Խñ� ����
     */
    @Transactional
    public Long save(final BoardRequestDto params) {

        Board entity = boardRepository.save(params.toEntity());
        return entity.getId();
    }

    /**
     * �Խñ� ����
     */
    @Transactional
    public Long update(final Long id, final BoardRequestDto params) {

        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));
        entity.update(params.getTitle(), params.getContent(), params.getWriter());
        return id;
    }

    /**
     * �Խñ� ����
     */
    @Transactional
    public Long delete(final Long id) {

        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));
        entity.delete();
        return id;
    }

    /**
     * �Խñ� ����Ʈ ��ȸ
     */
    public List<BoardResponseDto> findAll(String title) {

        Sort sort = Sort.by(Direction.DESC, "id", "createdDate");
        List<Board> list = new ArrayList<Board>();
        if(title == null || title.equals(null)) {
            list = boardRepository.findAll(sort);
        } else {
            list = boardRepository.findByTitleContainingAndDeleteYn(title, 'N');
        }
        return list.stream().map(BoardResponseDto::new).collect(Collectors.toList());
    }

    /**
     * �Խñ� ������ ��ȸ
     */
    @Transactional
    public BoardResponseDto findById(final Long id) {

        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));
        entity.increaseHits();
        return new BoardResponseDto(entity);
    }

}