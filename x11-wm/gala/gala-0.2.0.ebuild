# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils vala autotools-utils

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://launchpad.net/gala"
SRC_URI="https://launchpad.net/~elementary-os/+archive/ubuntu/stable/+files/gala_0.2.0%7Er464%2Bpkg32%7Eubuntu0.3.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	media-libs/clutter-gtk
	>=pantheon-base/plank-0.3
	>=x11-libs/granite-0.3
	x11-libs/bamf
	>=x11-libs/gtk+-3.4:3
	>=x11-wm/mutter-3.8.4
	gnome-base/gnome-desktop:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

AUTOTOOLS_AUTORECONF=1

src_unpack() {
	default_src_unpack

	mv "${WORKDIR}/gala-0.2.0~r460+pkg32~ubuntu0.3.1" "${S}"
}

src_prepare() {
	epatch_user

	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		VALAC="${VALAC}"
	)
	autotools-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
