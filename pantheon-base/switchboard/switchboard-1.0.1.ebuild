# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION="0.16"

inherit vala cmake-utils versionator

DESCRIPTION="Modular desktop settings hub"
HOMEPAGE="http://launchpad.net/switchboard"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-1).x/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
	>=x11-libs/granite-0.2.0
	dev-libs/libunity
	dev-libs/libgee"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING )
}

src_prepare() {
	# Disable generation of the translations (if needed)
	use nls || sed -i 's/add_subdirectory(po)//' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}
