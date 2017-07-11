# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bzr

DESCRIPTION="Plank theme for elementary OS"
HOMEPAGE="https://launchpad.net/plank-theme-pantheon"
EBZR_REPO_URI="lp:plank-theme-pantheon"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	pantheon-base/plank"

DOCS=( COPYING )

src_prepare() {
	eapply_user
	default
}

src_install() {
	insinto /usr/share/plank/themes
	doins -r Pantheon
}
