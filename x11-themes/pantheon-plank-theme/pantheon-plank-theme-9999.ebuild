# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit base bzr

DESCRIPTION="Plank theme for elementary OS, created to compliment the Pantheon desktop environment"
HOMEPAGE="https://launchpad.net/plank-theme-pantheon"
EBZR_REPO_URI="lp:plank-theme-pantheon"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	|| ( pantheon-base/pantheon-dock pantheon-base/plank )"

DOCS=( COPYING )

src_install() {
	insinto /usr/share/plank/themes
	doins -r Pantheon

	base_src_install_docs
}

