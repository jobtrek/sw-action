# SW action

This action can be used to set up [SW](https://github.com/jobtrek/sw) on your GitHub
action CD pipelines.

By default, the action will check your code with the same defaults as
[SW](https://github.com/jobtrek/sw?tab=readme-ov-file#defaults). You can pass
specific configuration directly to SW from the action parameters.

> v1.1.5

## Use this action in your repository

You need to set up a workflow that :

1. Check out the code of your repository.
1. Run the SW-action to wipe the solutions.
1. Copy the wiped files to a new repository or branch.
1. Commit the changes to the new repository or branch.
1. Make a pull request to the corresponding repository to propose the new wiped
exercises.

### Example action

- Here's a [simple example](action-example/simple-action.yml) of a workflow
that uses the SW-action to wipe the solutions of some exercises and commit
the changes to another repository,
- Here's [another example](action-examplel/with-ignore-file.yml) wich uses a
`.exerciseignore` to specify wich files shouldn't be copied to the new repository.

### Inputs

|  Name  |                                     Description                                     | Required |     Default     |
|--------|-------------------------------------------------------------------------------------|----------|-----------------|
| `path` |                The path to the directory containing the code to wipe                |   false  |       `.`       |
| `lang` | The languages of the code you want to wipe, separated by a comma and without spaces |   false  | `rs,js,ts,java` |

### Outputs

This action output the path to every file that has been wiped.
