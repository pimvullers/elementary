# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils vala

if [[ "${PV}" == "9999" ]]; then
	inherit bzr
	EBZR_REPO_URI="lp:${PN}"
	KEYWORDS=""
else
	SRC_URI="https://launchpad.net/${PN}/freya/${PV}/+download/${P}.tgz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Small utility to print documents"
HOMEPAGE="https://launchpad.net/${PN}"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)"

RESTRICT="mirror"

src_prepare() {
	eapply_user

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}
