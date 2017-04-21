# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit vala cmake-utils

if [[ "${PV}" == "9999" ]]; then
	inherit bzr
	EBZR_REPO_URI="lp:${PN}"
	KEYWORDS=""
else
	SRC_URI="https://launchpad.net/${PN}/loki/${PV}/+download/${P}.tar.xz"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="An easy parental controls plug for Switchboard"
HOMEPAGE="https://launchpad.net/switchboard-plug-parental-controls"

LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	>=pantheon-base/switchboard-2
	x11-libs/granite
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}
