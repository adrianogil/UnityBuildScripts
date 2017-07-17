import fire
import subprocess

class UnityBuild(object):
  """Build Unity projects """

  def build(self, current_commit='', \
                  repo='local', \
                  project_build_method='AutoBuilder.PerformAndroidBuild', \
                  unity_app='',
                  internal_folder=''):
    print('------ UnityBuild -----')

    git_tag_name = 'temp-unity-build-' + current_commit

if __name__ == '__main__':
  fire.Fire(UnityBuild)