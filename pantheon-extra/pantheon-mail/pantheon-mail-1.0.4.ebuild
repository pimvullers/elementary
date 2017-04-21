# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_VERSION=0.22
VALA_USE_DEPEND=vapigen

inherit cmake-utils vala

if [[ "${PV}" == "9999" ]]; then
	inherit bzr
	EBZR_REPO_URI="lp:${PN}"
	KEYWORDS=""
else
	SRC_URI="https://launchpad.net/${PN}/loki/${PV}/+download/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="The email client for Elementary OS"
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
		-DVAPIGEN="${VALA_API_GEN}"
	)

	cmake-utils_src_configure
}
