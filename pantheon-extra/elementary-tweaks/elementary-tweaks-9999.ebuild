# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vala cmake-utils bzr

DESCRIPTION="Tweak elementary OS"
HOMEPAGE="http://www.elementaryupdate.com/2013/06/finally-elementary-tweaks.html"
EBZR_REPO_URI="lp:elementary-community/elementary-tweaks"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}/${P}-sort.patch"
	eapply_user

	vala_src_prepare
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}
