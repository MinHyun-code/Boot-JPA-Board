package jpa.board.board;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import jpa.board.board.entity.Board;
import jpa.board.board.entity.BoardRepository;

@SpringBootTest
public class BoardTests {

    @Autowired
    BoardRepository boardRepository;

    @Test
    void save() {

        // 1. �Խñ� �Ķ���� ����
        Board params = Board.builder()
                .title("1�� �Խñ� ����")
                .content("1�� �Խñ� ����")
                .writer("������")
                .hits(0)
                .deleteYn('N')
                .build();

        
        // 2. �Խñ� ����
        boardRepository.save(params);

        // 3. 1�� �Խñ� ���� ��ȸ
//        Board entity = boardRepository.findById((long) 1).get();
//        assertThat(entity.getTitle()).isEqualTo("1�� �Խñ� ����");
//        assertThat(entity.getContent()).isEqualTo("1�� �Խñ� ����");
//        assertThat(entity.getWriter()).isEqualTo("������");
    }

    @Test
    void findAll() {

        // 1. ��ü �Խñ� �� ��ȸ
        long boardsCount = boardRepository.count();

        // 2. ��ü �Խñ� ����Ʈ ��ȸ
        List<Board> boards = boardRepository.findAll();
    }

    @Test
    void delete() {

        // 1. �Խñ� ��ȸ
        Board entity = boardRepository.findById((long) 15).get();

        // 2. �Խñ� ����
        boardRepository.delete(entity);
    }

}