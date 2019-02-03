Neural Commit Suggester
=======================

This is the implementation presented at FOSDEM 19 for [Neural commit message suggester: Proposing git commit messages with neural networks](https://fosdem.org/2019/schedule/event/ml_on_code_commit_message/).

Installation
------------
Install Sockeye the framework through:

```
pip install sockeye
```

Train the MT
------------
Data has already been tokenized.

Execute `train-suggester.sh`.

If you have a GPU, comment out `--use-cpu` flag. It will take approximately 11GB of GPU RAM for 5 hours on a Tesla V100.

Predict a commit message
------------------------
You can predict a commit message by specifying your model directory with `--model` parameter and by sending in diffs in a file passed as `--input` parameter, one diff per line (keep reading for the exact specification). 
Output commit messages go in a file specified by `--output` parameter.

```
sockeye-translate --models sockeye-commit-suggester-raw --use-cpu --input valid.3000.diff --output valid.raw.out
```

Diff format translates by replacing newlines with `<nl>` and `+++`/`---` signs in front of file names with `ppp`/`mmm`. Everything must be whitespace tokenized. 
Lines pointing to char references (typically beginning and ending with `@@`) are stripped.

So, the following:
```
--- a/kubernetes/ansible/ansible_config/tasks/docker.yml
+++ b/kubernetes/ansible/ansible_config/tasks/docker.yml
@@ -1,5 +1,8 @@
 - name: Create docker default nexus auth
   template:
     src: ../../ansible/roles/docker/files/docker-config_staging.json.j2
-    dest: ../../ansible/roles/docker/files/docker-config_staging.json
+    dest: "{{item}}"
     force: true
+  with_items:
+    - ../../ansible/roles/jenkins/files/docker-config.json
+    - ../../ansible/roles/docker/files/docker-config_staging.json
```

gets crammed to a single line like: 
```
mmm a / kubernetes / ansible / ansible_config / tasks / docker . yml <nl> ppp b / kubernetes / ansible / ansible_config / tasks / docker . yml <nl>  - name :  Create docker default nexus auth <nl>    template :  <nl>      src :   .  .  /  .  .  / ansible / roles / docker / files / docker-config_staging . json . j2 <nl> -    dest :   .  .  /  .  .  / ansible / roles / docker / files / docker-config_staging . json <nl> +    dest :  "{{item}}" <nl>      force :  true <nl> +  with_items :  <nl> +    -  .  .  /  .  .  / ansible / roles / jenkins / files / docker-config . json <nl> +    -  .  .  /  .  .  / ansible / roles / docker / files / docker-config_staging . json <nl> 
```

There is no script to do it since it was reverse engineered from the training set (which I did not generate, it was provided by [Siyuan Jiang](https://sjiang1.github.io/commitgen/) for CommitGen).
