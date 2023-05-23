package jpa.board.board.entity;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardRepository extends JpaRepository<Board, Long> {
	
	List<Board> findByTitleContainingAndDeleteYn(String title, char deleteYn);
}