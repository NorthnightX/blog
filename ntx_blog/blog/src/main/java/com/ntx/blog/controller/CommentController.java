package com.ntx.blog.controller;

import com.alibaba.fastjson.JSON;
import com.ntx.blog.VO.DeleteCommentVO;
import com.ntx.blog.VO.MsgDelVO;
import com.ntx.blog.domain.TComment;
import com.ntx.blog.service.TBlogService;
import com.ntx.blog.service.TCommentService;
import com.ntx.blog.utils.UserHolder;
import com.ntx.common.domain.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;


@RestController
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private TCommentService commentService;
    @Autowired
    private StringRedisTemplate redisTemplate;
    @Autowired
    private TBlogService blogService;
    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    /**
     * 新增评论
     * @param comment
     * @return
     */
    @PostMapping("/addComment")
    public Result addComment(@RequestBody TComment comment){
        try {
            Integer id = UserHolder.getUser().getId();
            comment.setUserId(id);
            kafkaTemplate.send("blogComment","", JSON.toJSONString(comment));
            return Result.success("评论成功");
        } finally {
            UserHolder.removeUser();
        }
    }

    /**
     * 查找BLog对应的评论
     * @param id
     * @return
     */
    @GetMapping("/getCommentByBlog/{id}")
    public Result queryCommentByBlogId(@PathVariable int id){
        return commentService.getCommentByBlog(id);
    }

    /**
     * 删除评论
     * @param commentVO
     * @return
     */
    @PutMapping("/deleteComment")
    public Result deleteComment(@RequestBody DeleteCommentVO commentVO) throws IOException {
        return commentService.deleteComment(commentVO);
    }

    /**
     * 获取该用户的消息列表
     * @return
     */
    @GetMapping("/getCommentMsg")
    public Result getCommentMsg(){
        return commentService.getCommentMessage();
    }

    /**
     * 删除消息列表的指定消息
     * @return
     */
    @DeleteMapping ("/delMsg")
    public Result delMsg(@RequestParam Integer id){
        return commentService.delMsg(id);
    }

}
