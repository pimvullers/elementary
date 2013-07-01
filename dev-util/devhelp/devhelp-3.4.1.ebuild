# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/Attic/devhelp-3.4.1.ebuild,v 1.12 2013/05/15 12:14:39 pacho dead $

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="2"

inherit eutils gnome2 python toolchain-funcs

DESCRIPTION="An API documentation browser for GNOME"
HOMEPAGE="http://live.gnome.org/devhelp"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

COMMON_DEPEND=">=gnome-base/gconf-2.6:2
	>=dev-libs/glib-2.25.11:2
	>=x11-libs/gtk+-3.0.2:3
	>=net-libs/webkit-gtk-1.6:3"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gsettings-desktop-schemas"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/gettext-0.17
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS NEWS README"
	# ICC is crazy, silence warnings (bug #154010)
	if [[ $(tc-getCC) == "icc" ]] ; then
		G2CONF="${G2CONF} --with-compile-warnings=no"
	fi
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Use gsettings-desktop-schemas instead of obsolete libgnome's
	# /desktop/gnome/interface/* gconf keys for fonts; bug #396637,
	# https://bugzilla.gnome.org/show_bug.cgi?id=646402
	epatch "${FILESDIR}/devhelp-3.4.1-gsettings-fonts.patch"

	gnome2_src_prepare

	python_clean_py-compile_files
}

pkg_preinst() {
	gnome2_pkg_preinst
	preserve_old_lib /usr/$(get_libdir)/libdevhelp-2.so.1
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize /usr/$(get_libdir)/gedit/plugins
	# Keep all the notify calls around so that users get reminded to delete them
	preserve_old_lib_notify /usr/$(get_libdir)/libdevhelp-1.so.1
	preserve_old_lib_notify /usr/$(get_libdir)/libdevhelp-2.so.1
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/gedit/plugins
}
