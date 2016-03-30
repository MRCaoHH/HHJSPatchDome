require('UIColor')
defineClass('ViewController', {
            handleBtn: function(sender) {
            var tableViewCtrl = HHViewController.alloc().init()
            self.navigationController().pushViewController_animated(tableViewCtrl, YES)
            }
            })

defineClass('HHViewController: UIViewController', {
            init:function(){
                  self=self.super().init();
                  if (self) {
                self.view().setBackgroundColor(UIColor.redColor());
                  }
                  return self;
            }

            })