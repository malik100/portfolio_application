class GithubProfile {
  String name;
  String site;
  String location;
  String twitter;
  String repos;
  String gists;
  String instagram;
  int reposcount;
  int gistscount;

  GithubProfile({String name, String repos, String gists,
      String twitter, String location, String site, int reposcount, int gistscount, String instagram}) {
        this.name = name;
        this.repos = repos;
        this.gists = gists;
        this.reposcount = reposcount;
        this.gistscount = gistscount;
        this.site = site;
        this.location = location;
        this.twitter = twitter;
        this.instagram = instagram;
      } 

  factory GithubProfile.fromJson(Map<String, dynamic> json) {
    return GithubProfile(
      name: json['name'],
      repos: json['repos_url'],
      gists: json['gists_url'],
      twitter: json['twitter_username'],
      location: json['location'],
      site: json['blog'],
      reposcount: json['public_repos'],
      gistscount: json['public_gists'],
      instagram: json['bio'],
    );
  }

  String getName() => this.name;
  String getSite() {
    return this.site;
  }
  String getLocation() => this.location;
  String getTwitter() => this.twitter;
  String getRepos() => this.repos;
  String getGists() => this.gists;
}
