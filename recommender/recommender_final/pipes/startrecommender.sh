mkfifo CTRL_PIPE
mkfifo STATUS_PIPE
mkfifo RES_PIPE
java -jar getreced.jar CTRL_PIPE STATUS_PIPE RES_PIPE initialmodfile
