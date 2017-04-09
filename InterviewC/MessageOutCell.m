//
//  MessageOutCell.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 03.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "MessageOutCell.h"

@interface MessageOutCell ()
@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIView *bubbleView;

@end


@implementation MessageOutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _bubbleView.layer.cornerRadius = 6;
    
    _textLbl.text = @"self.selectionStyle = UITableViewCellSelectionStyleNone; _bubbleView.layer.cornerRadius = 6; self.selectionStyle = UITableViewCellSelectionStyleNone; _bubbleView.layer.cornerRadius = 6;";

}

- (void)initWithChatObj:(ChatObj *)chatObj {
    _textLbl.text = @"Чтобы создать нечто новое, мне пришлось забыть обо всех правилах, которым я следовал раньше. Старые идеи полетели в помойку. В Dark Fantasy коллекция звуковых полотен впервые появилась в таком виде. Пятый альбом собрал в себе четыре предыдущих. Это было что-то вроде «Люк, я твой отец». Yeezus же стал началом нового Канье-художника. Я снова расширил свои знания об архитектуре, классицизме, обществе, фактуре, синестезии — способности воспринимать звук, обо всем по отдельности и о том, что все это представляет в целом. С Yeezus я решил начать все с чистого листа. Я не хотел использовать старую формулу и ставить первой в альбоме песню вроде Blood on the Leaves. Вместо этого я сделал семпл на Нину Симон. Чтобы заполучить внимание слушателя, расположить его к себе, я решил опереться на что-то всем знакомое из постмодерна. На самом деле я думаю, что самый неприятный звук во всем альбоме, — это как раз тот, с которого он начинается — такая новая версия радиозвука с помехами. Или звучание помех в интернете — вот как я бы описал начало альбома. Daft Punk написали этот звук. Он напоминает тот момент, когда в ресторане из-под стаканов, стоящих на столе, выдергивают скатерть. Такое ощущение должен оставлять трек On Sight.";
    _textLbl.text = chatObj.text;
    _nameLbl.text = chatObj.author;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
