package jpa.board.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/board")
public class BoardPageController {

    /**
     * �Խñ� ����Ʈ ������
     */
    @GetMapping("/list")
    public String openBoardList(@RequestParam(required = false) final String title, Model model) {
    	model.addAttribute("title", title);
        return "board/list";
    }

    /**
     * �Խñ� ��� ������
     */
    @GetMapping("/write")
    public String openBoardWrite(@RequestParam(required = false) final Long id, Model model) {
        model.addAttribute("id", id);
        return "board/write";
    }

    /**
     * �Խñ� �� ������
     */
    @GetMapping("/view/{id}")
    public String openBoardView(@PathVariable final Long id, @RequestParam(required = false) final String title, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("title", title);
        return "board/view";
    }

}